//
//  UIViewUtils.swift
//  ImageGallery
//
//  Created by Ahmed Abaza on 21/02/2022.
//

import UIKit


extension UIView {
    var width: CGFloat {
        self.frame.size.width
    }
    
    var height: CGFloat {
        self.frame.size.height
    }
    
    var topLeftCornerPoint: CGPoint {
        self.bounds.origin
    }
    
    var bottomRightCornerPoint: CGPoint {
        CGPoint(x: self.bounds.maxX, y: self.bounds.maxY)
    }
    
    var originY: CGFloat {
        self.bounds.minY
    }
    
    func upsideDown() -> Void {
        self.transform = CGAffineTransform(rotationAngle: .pi)
    }
}
