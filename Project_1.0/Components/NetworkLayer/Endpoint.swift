//
//  Endpoint.swift
//  Project_1.0
//
//  Created by Игорь Черныш on 05.12.2020.
//

import Foundation

let baseURL = "http://jsonplaceholder.typicode.com"

protocol TargetEndpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var header: [String: Any]? { get }
}
