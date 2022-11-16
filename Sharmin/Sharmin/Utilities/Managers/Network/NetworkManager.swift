//
//  NetworkManager.swift
//  mafia
//
//  Created by Dima Sviderskyi on 13.07.2021.
//

import Foundation

struct NetworkManager {
    
    static let shared: NetworkManager = { return NetworkManager() }()
    
    private let router = NetworkRouter<Api>()
    
}

// MARK: - Login Requests
extension NetworkManager {
    
    func fetch<T: Codable>(route: Api, completion: @escaping (Result<T, APIError>) -> ()) {
        router.request(route) { (maybeData, maybeResponse, maybeError) in
            
            guard let httpResponse = maybeResponse as? HTTPURLResponse else {
                completion(.failure(APIError(statusCode: 0,
                                             description: .invalidData)))
                return
            }
            
            if let error = maybeError {
                completion(.failure(APIError(statusCode: httpResponse.statusCode,
                                             description: .requestFailed(description: error.localizedDescription))))
                return
            }
            
            guard let data = maybeData else {
                completion(.failure(APIError(statusCode: httpResponse.statusCode,
                                             description: .invalidData)))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            } catch {
                debugPrint(error)
                completion(.failure(APIError(statusCode: httpResponse.statusCode,
                                             description: .jsonDecodingFailure)))
            }
        }
    }
}
