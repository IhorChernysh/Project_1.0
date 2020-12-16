//
//  ListOfPostsViewModel.swift
//  Project_1.0
//
//  Created by Игорь Черныш on 05.12.2020.
//

import Foundation
import RxSwift
import RxCocoa

class ListOfPostsViewModel {
    
    // MARK: - Properties
    
    var listOfPostsObservable: Observable<Bool> {
        return postsInfoSubject.asObservable()
    }
    var activityIndicatorObservable: Observable<Bool> {
        return activityIndicatorStartSubject.asObservable()
    }
    var selectPostInfoObservable: Observable<PostInfoCD> {
        return selectPostInfoSubject.asObservable()
    }
    
    let postsRepository: PostsRepositoryProtocol
    
    let disposeBag = DisposeBag()

    let selectPostInfoSubject = PublishSubject<PostInfoCD>()
    private let activityIndicatorStartSubject = PublishSubject<Bool>()
    private let postsInfoSubject = PublishSubject<Bool>()
    
    // MARK: - Init
    
    init(postsRepository: PostsRepository) {
        self.postsRepository = postsRepository        
    }
    
    // MARK: - Methods
    
    func fetchPostsInfo() {
        // check if all info already fetched from API
        if CoreDataService.shared.containPostsInfo() {
            setFetchedPostsInfo()
            return
        }
        
        activityIndicatorStartSubject.onNext(true)
        
        postsRepository.fetchPostInfo { [weak self] postsInfo, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                
                if let err = error {
                    self.postsInfoSubject.onError(err)
                    self.activityIndicatorStartSubject.onNext(false)
                    return
                }
                
                guard let postsInfo = postsInfo else { return }
                CoreDataService.shared.addPostsInfo(postsInfo)
                self.setFetchedPostsInfo()
            }
        }
    }
    
    private func setFetchedPostsInfo() {
        activityIndicatorStartSubject.onNext(false)
        postsInfoSubject.onNext(true)
    }
}
