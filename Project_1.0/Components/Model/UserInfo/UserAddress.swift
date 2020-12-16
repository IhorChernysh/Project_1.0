//
//  UserAddress.swift
//  Project_1.0
//
//  Created by Игорь Черныш on 06.12.2020.
//

import Foundation

protocol UserAddressProtocol: Decodable {
    var street: String? { get set }
    var suite: String? { get set }
    var city: String? { get set }
    var zipcode: String? { get set }
    var geo: UserAddressCoordinates? { get set }
}

struct UserAddress: UserAddressProtocol {
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
    var geo: UserAddressCoordinates?
}


protocol UserAddressCoordinatesProtocol: Decodable {
    var lat: String? { get set }
    var lng: String? { get set }
}

struct UserAddressCoordinates: UserAddressCoordinatesProtocol {
    var lat: String?
    var lng: String?
}
