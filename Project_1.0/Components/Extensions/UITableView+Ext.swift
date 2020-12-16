//
//  UITableView+Ext.swift
//
//  Created by ihor-ios
//  Copyright © 2020 ****** ******. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register(_ cellClass: AnyClass) {
        register(cellClass,
                 forCellReuseIdentifier: String(describing: cellClass))
    }
    
    func dequeue<T: UITableViewCell>(
        _ cellClass: T.Type, for indexPath: IndexPath) -> T? {
        dequeueReusableCell(withIdentifier: String(describing: cellClass),
                            for: indexPath) as? T
    }
    
    func dequeue<T: UITableViewCell>(
        _ cellClass: T.Type, for row: Int) -> T? {
        dequeue(cellClass, for: IndexPath(row: row, section: 0))
    }
}
