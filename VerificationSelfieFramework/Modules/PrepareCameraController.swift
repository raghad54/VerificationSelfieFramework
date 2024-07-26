////
////  PrepareCameraController.swift
////  VerificationSelfie
////
////  Created by Raghad's Mac on 22/07/2024.
////
//
import UIKit
import AVFoundation
import Vision

///doc: `PrepareCameraController` handles the camera setup, face detection, and UI updates for capturing photos. It uses `CameraManager` to interact with the camera and `FaceDetectionManager` to detect faces in the camera feed. It also manages the display of face rectangles and provides the captured image to its delegate.

public class PrepareCameraController: UIViewController {
  
    public var cameraManager: CameraManager!
    public var faceDetectionManager: FaceDetectionManager!
    public weak var delegate: PrepareCameraControllerDelegate?

    private var captureButton: UIButton!
    private var faceRectanglesOverlay: UIView!

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupFaceRectanglesOverlay()
        requestCameraPermission()
    }

    // MARK: - UI Setup

    private func setupUI() {
        view.backgroundColor = .black

        captureButton = UIButton(type: .system)
        captureButton.setTitle("Capture", for: .normal)
        captureButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        captureButton.setTitleColor(.white, for: .normal)
        captureButton.backgroundColor = .systemBlue
        captureButton.layer.cornerRadius = 10
        captureButton.addTarget(self, action: #selector(captureButtonPressed), for: .touchUpInside)
        captureButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(captureButton)

        NSLayoutConstraint.activate([
            captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            captureButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            captureButton.widthAnchor.constraint(equalToConstant: 100),
            captureButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        captureButton.isHidden = true
    }

    private func setupFaceRectanglesOverlay() {
        faceRectanglesOverlay = UIView()
        faceRectanglesOverlay.translatesAutoresizingMaskIntoConstraints = false
        faceRectanglesOverlay.isUserInteractionEnabled = false
        view.addSubview(faceRectanglesOverlay)

        NSLayoutConstraint.activate([
            faceRectanglesOverlay.topAnchor.constraint(equalTo: view.topAnchor),
            faceRectanglesOverlay.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            faceRectanglesOverlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            faceRectanglesOverlay.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
            DispatchQueue.main.async {
                if granted {
                    self?.setupCamera()
                } else {
                    ShowAlert.handleError(.cameraAccessDenied, in: self!)
                }
            }
        }
    }

    private func setupCamera() {
        cameraManager.setupCamera(in: view)
        cameraManager.delegate = self
    }

    @objc private func captureButtonPressed() {
        cameraManager.capturePhoto()
    }

    private func updateCaptureButtonVisibility(isVisible: Bool) {
        DispatchQueue.main.async {
            self.captureButton.isHidden = !isVisible
        }
    }

    private func showError(_ error: ErrorsHandlerForOpenCamaerEnum) {
           ShowAlert.handleError(error, in: self)
       }


    private func drawFaceRectangles(_ faceObservations: [VNFaceObservation]) {
        DispatchQueue.main.async {
            self.faceRectanglesOverlay.subviews.forEach { $0.removeFromSuperview() }

            for faceObservation in faceObservations {
                let faceRect = self.transformFaceRect(faceObservation.boundingBox)
                let faceView = UIView(frame: faceRect)
                faceView.layer.borderColor = UIColor.red.cgColor
                faceView.layer.borderWidth = 2
                self.faceRectanglesOverlay.addSubview(faceView)
            }
        }
    }

    private func transformFaceRect(_ boundingBox: CGRect) -> CGRect {
        let size = faceRectanglesOverlay.bounds.size
        let width = boundingBox.width * size.width
        let height = boundingBox.height * size.height
        let x = boundingBox.origin.x * size.width
        let y = (1 - boundingBox.origin.y - boundingBox.height) * size.height
        return CGRect(x: x, y: y, width: width, height: height)
    }
}

// MARK: - CameraManagerDelegate

extension PrepareCameraController: CameraManagerDelegate {
    public func didCapture(image: UIImage) {
        let previewVC = PreviewViewController()
        previewVC.image = image
        previewVC.delegate = self
        present(previewVC, animated: true)
    }

    public func didDetectFaces(_ faceObservations: [VNFaceObservation]) {
        let isFaceDetected = !faceObservations.isEmpty
        updateCaptureButtonVisibility(isVisible: isFaceDetected)
        drawFaceRectangles(faceObservations)
    }

    public func didEncounterError(_ error: ErrorsHandlerForOpenCamaerEnum) {
        showError(error)
    }
}

extension PrepareCameraController: PreviewViewControllerDelegate {
    public func didAccept(image: UIImage) {
        delegate?.didAccept(image: image)
        navigationController?.popViewController(animated: true)
    }
    public func didReject() {
        
    }
    
}
