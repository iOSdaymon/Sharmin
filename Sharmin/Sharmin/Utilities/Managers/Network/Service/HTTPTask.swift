//
//  HTTPTask.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 15.11.2022.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters? = nil,
                           bodyEncoding: ParameterEncoding,
                           urlParameters: Parameters? = nil)
    
}


