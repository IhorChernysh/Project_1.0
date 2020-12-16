//
//  PostsAPI.swift
//  Project_1.0
//
//  Created by Игорь Черныш on 05.12.2020.
//

import Foundation

protocol PostsAPIProtocol {
    func fetchJSON<T: Decodable>(target: PostsEndpoint, completion: @escaping ((Result<[T], Error>)->()))
}

class PostsAPI: PostsAPIProtocol {
    
    // MARK: - Properties
    
    private let session = URLSession.shared
    
    // MARK: - Methods
    
    func fetchJSON<T: Decodable>(target: PostsEndpoint, completion: @escaping ((Result<[T], Error>) -> ())) {
        guard let url = URL(string: "\(baseURL)\(target.path)") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        
        session.dataTask(with: request) { (data, response, error) in
            if let err = error {
                completion(.failure(err))
                return
            }
            guard let data = data else {
                completion(.failure(APIError.dataIsNil))
                return
            }
            do {
                let json = try JSONDecoder().decode([T].self, from: data)
                completion(.success(json))
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
    }
}
