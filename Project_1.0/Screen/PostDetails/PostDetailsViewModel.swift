//
//  PostDetailsViewModel.swift
//  Project_1.0
//
//  Created by Игорь Черныш on 06.12.2020.
//

import Foundation
import RxSwift
import RxCocoa

struct DetailInfo {
    var postInfo: PostInfoCD?
    var userInfo: UserInfoCD?
    var comments: [UserCommentsCD]?
}

class PostDetailsViewModel {
 
    // MARK: - Properties
    
    var sections: [DetailsType] = [.postInfo, .profileInfo, .comments]
    var postDetailInfoRelay = BehaviorRelay<DetailInfo?>(value: nil)
    
    var pickedPostInfoObservable: Observable<PostInfoCD> {
        return selectedPostInfoSubject.asObservable()
    }
    
    var activityIndicatorObservable: Observable<Bool> {
        return activityIndicatorStartSubject.asObservable()
    }
    
    private let selectedPostInfoCD: PostInfoCD
    private let postsRepository: PostsRepositoryProtocol

    private let activityIndicatorStartSubject = PublishSubject<Bool>()
    private let selectedPostInfoSubject = PublishSubject<PostInfoCD>()
    
    private let disposeBag = DisposeBag()
    
    private let dispatchGroup = DispatchGroup()
    
    // MARK: - Init
    
    init(postsRepository: PostsRepository, selectedPostInfo: PostInfoCD) {
        self.postsRepository = postsRepository
        self.selectedPostInfoCD = selectedPostInfo
    }
    
    // MARK: - Methods
    
    func checkContainsProfileInfo() {
        // check if all info already fetched from API
        activityIndicatorStartSubject.onNext(true)

        if CoreDataService.shared.containUserInfo() {
            setFetchedInfo()
        } else {
            fetchComments()
            fetchUserInfo()
            
            dispatchGroup.notify(queue: DispatchQueue.main) {
                self.setFetchedInfo()
            }
        }
    }
    
    // Fetch from API
    
    func fetchComments() {
        dispatchGroup.enter()
        
        postsRepository.fetchComments { [weak self] userComments, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let err = error {
                    self.selectedPostInfoSubject.onError(err)
                    self.activityIndicatorStartSubject.onNext(false)
                    self.dispatchGroup.leave()
                    return
                }
                
                guard let userComments = userComments else { return }
                CoreDataService.shared.addUserComments(userComments)
                self.dispatchGroup.leave()
            }
        }
    }
    
    func fetchUserInfo() {
        dispatchGroup.enter()

        postsRepository.fetchUsers { [weak self] usersInfo, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let err = error {
                    self.selectedPostInfoSubject.onError(err)
                    self.activityIndicatorStartSubject.onNext(false)
                    self.dispatchGroup.leave()
                    return
                }
                
                guard let usersInfo = usersInfo else { return }
                CoreDataService.shared.addUsers(usersInfo)
                self.dispatchGroup.leave()
            }
        }
    }
    
    // Set after all info from API fetched
    
    private func setFetchedInfo() {
        activityIndicatorStartSubject.onNext(false)
        loadUserAndCommentsFromCoreData()
    }
    
    private func loadUserAndCommentsFromCoreData() {
        var detailInfo = DetailInfo()
        if let userInfo = CoreDataService.shared.fetchUserInfo(userID: Int(selectedPostInfoCD.userId)) {
            detailInfo.postInfo = selectedPostInfoCD
            detailInfo.userInfo = userInfo
            
        }
        if let userComments = CoreDataService.shared.fetchUserComments(id: Int(selectedPostInfoCD.id)) {
            detailInfo.comments = userComments
        }
        
        postDetailInfoRelay.accept(detailInfo)
    }
}
