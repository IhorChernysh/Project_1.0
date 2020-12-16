//
//  UserInfo.swift
//  Project_1.0
//
//  Created by Игорь Черныш on 06.12.2020.
//

import Foundation

protocol UserInfoProtocol: Decodable {
    var id: Int? { get set }
    var name: String? { get set }
    var username: String? { get set }
    var email: String? { get }
    var address: UserAddress? { get set }
    var phone: String? { get set }
    var website: String? { get set }
    var company: UserCompany? { get set }
}

struct UserInfo: UserInfoProtocol {
    var id: Int?
    var name: String?
    var username: String?
    var email: String?
    var address: UserAddress?
    var phone: String?
    var website: String?
    var company: UserCompany?
}
