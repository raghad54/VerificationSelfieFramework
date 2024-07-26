//
//  FaceRectanglesOverlayView.swift
//  VerificationSelfieFramework
//
//  Created by Raghad's Mac on 25/07/2024.
//

import UIKit
import Vision

public class FaceRectanglesOverlayView: UIView {
  public var faceObservations: [VNFaceObservation] = [] {
        didSet {
            setNeedsDisplay()
        }
    }

    // Define the width of the rectangle border
    var borderWidth: CGFloat = 4.0

    override public func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.clear(rect)
        
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(borderWidth)
        
        for face in faceObservations {
            let boundingBox = face.boundingBox
            let convertedRect = self.convertRect(fromBoundingBox: boundingBox)
            context.addRect(convertedRect)
            context.strokePath()
        }
    }

    private func convertRect(fromBoundingBox boundingBox: CGRect) -> CGRect {
        // Convert the bounding box from Vision coordinates to view coordinates
        let viewWidth = bounds.width
        let viewHeight = bounds.height
        let rect = CGRect(
            x: boundingBox.origin.x * viewWidth,
            y: (1 - boundingBox.origin.y - boundingBox.size.height) * viewHeight,
            width: boundingBox.size.width * viewWidth,
            height: boundingBox.size.height * viewHeight
        )
        return rect
    }
}

