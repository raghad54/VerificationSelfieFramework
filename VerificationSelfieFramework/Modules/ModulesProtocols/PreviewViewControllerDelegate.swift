//
//  PreviewViewControllerDelegate.swift
//  VerificationSelfieFramework
//
//  Created by Raghad's Mac on 26/07/2024.
//

import UIKit

public protocol PreviewViewControllerDelegate: AnyObject {
    func didAccept(image: UIImage)
    func didReject()
}
