//
//  NavigationController.swift
//  VerificationSelfiee
//
//  Created by Raghad's Mac on 26/07/2024.
//

import Foundation
import UIKit


extension UINavigationController {
    func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
    
    func dismissRootViewController() {
        if let navigationController = presentingViewController as? UINavigationController {
            navigationController.popToRootViewController(animated: true)
        } else {
            presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension UIViewController {
    static func topMostViewController() -> UIViewController? {
        var topController = UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController
        while let presentedViewController = topController?.presentedViewController {
            topController = presentedViewController
        }
        return topController
    }
}
