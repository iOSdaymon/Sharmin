//
//  APIError.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 15.11.2022.
//

import Foundation

struct APIError: Error {
    
    enum Description {
        case invalidData
        case jsonDecodingFailure
        case requestFailed(description: String)
        
        var customDescription: String {
            switch self {
            case .requestFailed(let description):
                return description
            case .invalidData:
                return KeysForTranslate.invalidData.localized
            case .jsonDecodingFailure:
                return KeysForTranslate.JSONDecodingFailure.localized
            }
        }
    }
    
    var statusCode: Int
    var description: Description
}
