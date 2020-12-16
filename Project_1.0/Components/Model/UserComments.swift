//
//  UserComments.swift
//  Project_1.0
//
//  Created by Игорь Черныш on 06.12.2020.
//

import Foundation

protocol UserCommentsProtocol: Decodable {
    var postId: Int? { get set }
    var id: Int? { get set }
    var name: String? { get set }
    var email: String? { get set }
    var body: String? { get set }
}

struct UserComments: UserCommentsProtocol {
    var postId: Int?
    var id: Int?
    var name: String?
    var email: String?
    var body: String?
}
