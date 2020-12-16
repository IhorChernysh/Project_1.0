//
//  AppCoordinator.swift
//
//  Created by ihor-ios
//  Copyright © 2020. All rights reserved.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    
    // MARK: - Properties
    
    private var window: UIWindow?
    
    // MARK: - Init
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    // MARK: - Methods
    
    override func start() {
        window?.makeKeyAndVisible()
        
        launchInitialVC()
    }
    
    // MARK: - Private methods
    
    private func launchInitialVC() {
        // here we can check the state of the APP and open a necessary VC
        lauchMainVC()
    }
    
    private func lauchMainVC() {
        let postsRepository = PostsRepository(postAPI: PostsAPI())
        let viewModel = ListOfPostsViewModel(postsRepository: postsRepository)
        let rootVC = UINavigationController(rootViewController: ListOfPostsViewController(viewModel: viewModel))
        let coordinator = ListOfPostsCoordinator(viewModel: viewModel, navigationController: navigationController)
        coordinator.start()
        coordinator.navigationController = rootVC
        
        window?.rootViewController = rootVC
    }
}
