//
//  PostsEndpoint.swift
//  Project_1.0
//
//  Created by Игорь Черныш on 05.12.2020.
//

import Foundation

enum PostsEndpoint {
    case getListOfPosts
    case getUsers
    case getComments
}

extension PostsEndpoint: TargetEndpoint {
    var path: String {
        switch self {
        case .getListOfPosts:
            return "/posts"
        case .getUsers:
            return "/users"
        case .getComments:
            return "/comments"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var header: [String : Any]? {
        return nil
    }
}
