//
//  UIButton+Ext.swift
//
//  Created by ihor-ios
//  Copyright © 2020 PULS. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(title: String,
                     image: UIImage? = nil,
                     titleColor: UIColor,
                     font: UIFont? = nil,
                     backgroundColor: UIColor = .white,
                     cornerRadius: CGFloat? = nil) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        
        if let image = image {
            self.setImage(image, for: .normal)
            centerTextAndImage(spacing: 8)
        }
        
        if let cornerRadius = cornerRadius {
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = true
        }
        
        if let font = font {
            self.titleLabel?.font = font
        }
    }
    
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
}
