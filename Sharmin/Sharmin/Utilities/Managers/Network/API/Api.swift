//
//  Api.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 15.11.2022.
//

import Foundation

public enum Api {
    case users
    case posts
}

extension Api: EndPointType {
    
    private var apiVersion: String {
        return "api/"
    }
    
    var baseURL: URL {
        guard let baseURLString = StoreManager.shared.baseURL,
              let url = URL(string: baseURLString) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .users:
            return "users"
        case .posts:
            return "posts"
        }
    }
    
    var apiPath: String {
        return apiVersion + path
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .users, .posts:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .users, .posts:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}


