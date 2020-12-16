//
//  UIView+Ext.swift
//
//  Created by ihor-ios
//  Copyright © 2020 ****** ******. All rights reserved.
//

import UIKit
import JGProgressHUD

extension UIView {
    convenience init(color: UIColor) {
        self.init()
        self.backgroundColor = color
    }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
    
    // MARK: - Shadow
    
    func addShadow(color: UIColor,
                   radius: CGFloat = 1,
                   opacity: Float = 1,
                   offset: CGSize = .zero,
                   masksToBounds: Bool = false) {
        self.layer.shadowColor = color.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
    }
    
    // MARK: - Blur
    
    func createBlurOverlay(blurEffectAlpha: CGFloat) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.alpha = blurEffectAlpha
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }
    
    func removeBlurOverlay() {
        let blurredEffectViews = subviews.filter { $0 is UIVisualEffectView }
        blurredEffectViews.forEach { $0.removeFromSuperview() }
    }
    
    // MARK: - Dashed lines
    
    func addDashedBorder(color: UIColor) {
        //Create a CAShapeLayer
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 2
        // passing an array with the values [2,3] sets a dash pattern that alternates between a 2-user-space-unit-long painted segment and a 3-user-space-unit-long unpainted segment
        shapeLayer.lineDashPattern = [10,10]
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0),
                                CGPoint(x: self.frame.width, y: 0)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
    
    // MARK: - Add and remove spinner
    
    func addSpinner(progressHud: JGProgressHUD) {
        let blurOverlay = self.createBlurOverlay(blurEffectAlpha: 0.7)
        self.addSubview(blurOverlay)
        progressHud.show(in: self)
    }
    
    func removeSpinner(progressHud: JGProgressHUD) {
        progressHud.dismiss()
        self.removeBlurOverlay()
    }
    
    func removeAnimated(withDuration duration: TimeInterval = 0.25) {
        UIView.animate(withDuration: duration, delay: 0.0, options: [.transitionCrossDissolve], animations: { self.alpha = 0.0 }, completion: { isFinished in
             if isFinished { self.removeFromSuperview() }
        })
    }
    
    func removeWithAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
}
