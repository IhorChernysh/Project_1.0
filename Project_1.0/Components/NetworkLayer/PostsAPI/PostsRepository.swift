//
//  PostsRepository.swift
//  Project_1.0
//
//  Created by Игорь Черныш on 06.12.2020.
//

import Foundation

protocol PostsRepositoryProtocol {
    func fetchPostInfo(completion: @escaping (([PostInfo]?, Error?)->()))
    func fetchUsers(completion: @escaping (([UserInfo]?, Error?)->()))
    func fetchComments(completion: @escaping (([UserComments]?, Error?)->()))
}

class PostsRepository: PostsRepositoryProtocol {
    
    // MARK: - Properties
    
    private let postsAPI: PostsAPIProtocol
    
    // MARK: - Init
    
    init(postAPI: PostsAPI) {
        self.postsAPI = postAPI
    }
    
    // MARK: - Methods
    
    func fetchPostInfo(completion: @escaping (([PostInfo]?, Error?)->())) {
        postsAPI.fetchJSON(target: .getListOfPosts) { (result: Result<[PostInfo], Error>) in
            switch result {
            case .success(let info):
                completion(info, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func fetchUsers(completion: @escaping (([UserInfo]?, Error?)->())) {
        postsAPI.fetchJSON(target: .getUsers) { (result: Result<[UserInfo], Error>) in
            switch result {
            case .success(let info):
                completion(info, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func fetchComments(completion: @escaping (([UserComments]?, Error?)->())) {
        postsAPI.fetchJSON(target: .getComments) { (result: Result<[UserComments], Error>) in
            switch result {
            case .success(let info):
                completion(info, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
