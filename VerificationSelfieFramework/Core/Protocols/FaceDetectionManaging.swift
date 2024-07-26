//
//  FaceDetectionManaging.swift
//  VerificationSelfieFramework
//
//  Created by Raghad's Mac on 26/07/2024.
//

import UIKit
import Vision

public protocol FaceDetectionManagerDelegate: AnyObject {
    func didDetectFaces(_ faceObservations: [VNFaceObservation])
    func didEncounterError(_ error: Error)
}
