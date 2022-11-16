//
//  JSONEncoding.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 15.11.2022.
//

import Foundation

public struct JSONParameterEncoder: ParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: Constants.Text.contentType) == nil {
                urlRequest.setValue(Constants.Text.applicationJson, forHTTPHeaderField: Constants.Text.contentType)
            }
        }catch {
            throw NetworkError.encodingFailed
        }
    }
}

