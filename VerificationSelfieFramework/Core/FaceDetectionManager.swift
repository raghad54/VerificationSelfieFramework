//
//  FaceDetection.swift
//  verificationSelfie
//
//  Created by Raghad's Mac on 21/07/2024.
//

import UIKit
import Vision

/// doc: Manages face detection functionality using the Vision framework.
///
/// `FaceDetectionManager` is responsible for setting up and performing face detection requests using the Vision framework. It processes image data to detect faces and provides the results via a delegate.
///
public class FaceDetectionManager {
    private var requests: [VNRequest] = []
    public var delegate: FaceDetectionManagerDelegate!

    public init() {
        setupFaceDetectionRequest()
    }

    private func setupFaceDetectionRequest() {
        let request = VNDetectFaceRectanglesRequest { [weak self] request, error in
            if let error = error {
                print("Face detection error: \(error)")
                return
            }

            guard let observations = request.results as? [VNFaceObservation] else { return }
            self?.handleFaceDetectionResults(observations)
        }
        requests = [request]
    }

    public func performFaceDetection(on ciImage: CIImage, completion: @escaping ([VNFaceObservation]) -> Void) {
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        do {
            try handler.perform(requests)
        } catch {
            print("Error performing face detection: \(error)")
            completion([])
            return
        }

        guard let request = requests.first,
              let results = request.results as? [VNFaceObservation] else {
            completion([])
            return
        }

        completion(results)
    }

    private func handleFaceDetectionResults(_ faceObservations: [VNFaceObservation]) {
        // Handle face detection results if needed
    }
}
