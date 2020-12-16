//
//  PostInfo.swift
//  Project_1.0
//
//  Created by Игорь Черныш on 05.12.2020.
//

import Foundation

protocol PostInfoProtocol: Decodable {
    var userId: Int? { get set }
    var id: Int? { get set }
    var title: String? { get set }
    var body: String? { get set }
}

struct PostInfo: PostInfoProtocol {
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?
}
