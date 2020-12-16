//
//  ListOfPostsCoordinator.swift
//  Project_1.0
//
//  Created by Игорь Черныш on 05.12.2020.
//

import UIKit

class ListOfPostsCoordinator: BaseCoordinator {
 
    // MARK: - Properties
    
    private var viewModel: ListOfPostsViewModel!
    
    // MARK: - Init
    
    init(viewModel: ListOfPostsViewModel, navigationController: UINavigationController) {
        super.init()
        self.viewModel = viewModel
        self.navigationController = navigationController
        
        setupBinding()
    }
    
    // MARK: - Methods
    
    override func start() {
        self.start(coordinator: self)
    }
    
    private func setupBinding() {
        viewModel
            .selectPostInfoObservable
            .subscribe(onNext: { [weak self] postInfoCD in
                self?.openDetailVC(postInfoCD: postInfoCD)
            }).disposed(by: viewModel.disposeBag)
    }
    
    private func openDetailVC(postInfoCD: PostInfoCD) {
        let postsRepository = PostsRepository(postAPI: PostsAPI())
        let detailsVC = PostDetailsViewController(postDetailsViewModel: PostDetailsViewModel(postsRepository: postsRepository, selectedPostInfo: postInfoCD))
        navigationController.pushViewController(detailsVC, animated: true)
    }
}
