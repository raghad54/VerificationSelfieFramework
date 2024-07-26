//
//  CameraManagerDelegate.swift
//  VerificationSelfieFramework
//
//  Created by Raghad's Mac on 26/07/2024.
//

import UIKit
import Vision

public protocol CameraManagerDelegate: AnyObject {
    func didCapture(image: UIImage)
    func didDetectFaces(_ faceObservations: [VNFaceObservation])
    func didEncounterError(_ error: ErrorsHandlerForOpenCamaerEnum)
}
