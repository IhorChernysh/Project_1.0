//
//  UIViewController+Ext.swift
//
//  Created by ihor-ios
//  Copyright © 2020 ****** ******. All rights reserved.
//

import UIKit
import RxSwift

extension UIViewController {
    func alert(title: String?, message: String?, actions: [UIAlertAction], style: UIAlertController.Style) -> UIAlertController {
        let alertContoller = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach {
            alertContoller.addAction($0)
        }
        return alertContoller
    }
    
    func addChildVC(_ viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    func removeChildVC() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    func displayError(error: Error) {
        let alertVC = self.alert(title: "Something wrong", message: error.localizedDescription, actions: [UIAlertAction(title: "OK", style: .default)], style: .alert)
        present(alertVC, animated: true)
    }
}
