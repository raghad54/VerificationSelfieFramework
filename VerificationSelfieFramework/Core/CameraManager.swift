//
//  HandleCamera.swift
//  verificationSelfie
//
//  Created by Raghad's Mac on 21/07/2024.
//


import AVFoundation
import UIKit
import Vision


// MARK: - CameraManager
///doc: `CameraManager` is responsible for configuring the camera session, capturing photos, and performing face detection.
/// It uses `AVCapturePhotoCaptureDelegate` to handle photo capture events and `AVCaptureVideoDataOutputSampleBufferDelegate` for processing video frames.
/// 
@objcMembers
public class CameraManager: NSObject {
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private var capturePhotoOutput: AVCapturePhotoOutput!
    private var faceDetectionManager: FaceDetectionManager
    private var isFaceDetected: Bool = false
    public weak var delegate: CameraManagerDelegate?

    public init(faceDetectionManager: FaceDetectionManager) {
        self.faceDetectionManager = faceDetectionManager
        super.init()
    }

    public func setupCamera(in view: UIView) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession = AVCaptureSession()
            self.captureSession.sessionPreset = .photo

            guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
                DispatchQueue.main.async {
                    self.delegate?.didEncounterError(.cameraSetupFailed)
                    ShowAlert.handleError(.cameraSetupFailed, in: UIViewController.topMostViewController() ?? UIViewController())

                }
                return
            }

            do {
                let input = try AVCaptureDeviceInput(device: frontCamera)
                if self.captureSession.canAddInput(input) {
                    self.captureSession.addInput(input)
                }

                self.capturePhotoOutput = AVCapturePhotoOutput()
                if self.captureSession.canAddOutput(self.capturePhotoOutput) {
                    self.captureSession.addOutput(self.capturePhotoOutput)
                }

                let videoOutput = AVCaptureVideoDataOutput()
                videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
                if self.captureSession.canAddOutput(videoOutput) {
                    self.captureSession.addOutput(videoOutput)
                }

                DispatchQueue.main.async {
                    self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
                    self.previewLayer.videoGravity = .resizeAspectFill
                    self.previewLayer.frame = view.layer.bounds
                    view.layer.insertSublayer(self.previewLayer, at: 0)
                    self.captureSession.startRunning()
                }
            } catch {
                DispatchQueue.main.async {
                    self.delegate?.didEncounterError(.cameraSetupFailed)
                    ShowAlert.handleError(.cameraSetupFailed, in: UIViewController.topMostViewController() ?? UIViewController())
                }
            }
        }
    }

    public func capturePhoto() {
        guard isFaceDetected else {
            DispatchQueue.main.async {
                self.delegate?.didEncounterError(.faceDetectionFailed)
                ShowAlert.handleError(.faceDetectionFailed, in: UIViewController()) // Replace with the appropriate view controller
            }
            return
        }

        let photoSettings = AVCapturePhotoSettings()
        capturePhotoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
}

// MARK: - AVCapturePhotoCaptureDelegate

extension CameraManager: AVCapturePhotoCaptureDelegate {
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            DispatchQueue.main.async {
                self.delegate?.didEncounterError(.photoCaptureFailed)
                ShowAlert.handleError(.photoCaptureFailed, in: UIViewController()) // Replace with the appropriate view controller
            }
            return
        }

        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else {
            DispatchQueue.main.async {
                self.delegate?.didEncounterError(.photoCaptureFailed)
                ShowAlert.handleError(.photoCaptureFailed, in: UIViewController()) // Replace with the appropriate view controller
            }
            return
        }

        DispatchQueue.main.async {
            self.delegate?.didCapture(image: image)
        }
    }
}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate

extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }

        let ciImage = CIImage(cvPixelBuffer: imageBuffer)
        faceDetectionManager.performFaceDetection(on: ciImage) { [weak self] faceObservations in
            DispatchQueue.main.async {
                self?.isFaceDetected = !faceObservations.isEmpty
                self?.delegate?.didDetectFaces(faceObservations)
            }
        }
    }
}
