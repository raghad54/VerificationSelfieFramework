//
//  ErrorsHandler.swift
//  verificationSelfie
//
//  Created by Raghad's Mac on 21/07/2024.
//

import Foundation
import UIKit


public enum ErrorsHandlerForOpenCamaerEnum: Error {
    case cameraAccessDenied
    case cameraSetupFailed
    case faceDetectionFailed
    case photoCaptureFailed

    var localizedDescription: String {
        switch self {
        case .cameraAccessDenied:
            return "Camera access is denied. Please allow camera access in settings."
        case .cameraSetupFailed:
            return "Failed to set up the camera."
        case .faceDetectionFailed:
            return "Face detection failed."
        case .photoCaptureFailed:
            return "Failed to capture photo."
        }
    }
}


public class ShowAlert {
    public static func handleError(_ error: ErrorsHandlerForOpenCamaerEnum, in viewController: UIViewController) {
        let alert = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        viewController.present(alert, animated: true)
    }
}
