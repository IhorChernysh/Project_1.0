//
//  Coordinator.swift
//
//  Created by ihor-ios
//  Copyright © 2020. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var parentCoordinator: Coordinator? { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    func start(coordinator: Coordinator)
    func finish(coordinator: Coordinator)
}
