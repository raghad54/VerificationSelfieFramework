//
//  PrepareCameraControllerDelegate.swift
//  VerificationSelfieFramework
//
//  Created by Raghad's Mac on 26/07/2024.
//

import UIKit


public protocol PrepareCameraControllerDelegate: AnyObject {
    func didAccept(image: UIImage)
}
