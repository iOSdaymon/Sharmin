//
//  StoreManager.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 15.11.2022.
//

import Foundation

class StoreManager  {
    
    static let shared = StoreManager()
}

// MARK: - KeychainManager
extension StoreManager {
    
    private struct Key {
        static let baseURL = "BaseURL"
    }
    
    private var infoPlistDictionary: [String:AnyObject]? {
        guard let path = Bundle.main.path(forResource: Constants.Text.infoplistFilename,
                                          ofType: Constants.Text.plistExtension) else { return nil }
        return NSDictionary(contentsOfFile: path) as? [String: AnyObject]
    }
    
    var baseURL: String? {
        get {
            return infoPlistDictionary?[Key.baseURL] as? String
        }
    }
}
