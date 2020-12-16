//
//  UILabel+Ext.swift
//
//  Created by ihor-ios
//  Copyright © 2020 ****** ******. All rights reserved.
//

import UIKit

extension UILabel {
    var maxNumberOfLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let text = (self.text ?? "") as NSString
        let textHeight = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font ?? UIFont.systemFont(ofSize: 16)], context: nil).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
    
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1, textAlignment: NSTextAlignment = .left, textColor: UIColor = .black) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
        self.textAlignment = textAlignment
        self.textColor = textColor
    }
    
    func heightForView(text: String, font: UIFont, width: CGFloat, attributedString: NSAttributedString? = nil) -> CGFloat{
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        if let attrString = attributedString {
            label.attributedText = attrString
        } else {
            label.text = text
        }
        label.sizeToFit()

        return label.frame.height
    }
}
