//
//  UserCompany.swift
//  Project_1.0
//
//  Created by Игорь Черныш on 06.12.2020.
//

import Foundation

protocol UserCompanyProtocol: Decodable {
    var name: String? { get set }
    var catchPhrase: String? { get set }
    var bs: String? { get set }
}

struct UserCompany: UserCompanyProtocol {
    var name: String?
    var catchPhrase: String?
    var bs: String?
}
