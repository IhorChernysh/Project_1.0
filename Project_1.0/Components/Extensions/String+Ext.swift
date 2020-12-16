//
//  String+Ext.swift
//
//  Created by ihor-ios
//  Copyright © 2020 ****** ******. All rights reserved.
//

import UIKit

extension String {
    var firstCapitalized: String {
        guard let first = first else { return "" }
        return String(first).capitalized + dropFirst()
    }
    
    func convertToDate(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "de_De")
        let date = formatter.date(from: self)
        return date
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.width)
    }
    
    func createAttributedString(font: UIFont?, lineSpacing: CGFloat = 1.25) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        let fontAttribute: [NSAttributedString.Key: Any] = [.font: font ?? UIFont.systemFont(ofSize: 14),
                                                            .paragraphStyle: paragraphStyle]
        return NSAttributedString(string: self, attributes: fontAttribute)
    }
    
    func createImageAttachmentString(image: UIImage?, imagePosition: CGPoint = .init(x: 0, y: 0), imageSize: CGSize) -> NSMutableAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = .init(x: imagePosition.x, y: imagePosition.y, width: imageSize.width, height: imageSize.height)
        let attributedStringImage = NSAttributedString(attachment: attachment)
        let mutableString = NSMutableAttributedString(attributedString: attributedStringImage)
        return mutableString
    }
}
