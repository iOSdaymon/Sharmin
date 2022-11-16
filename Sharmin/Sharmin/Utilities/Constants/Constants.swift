//
//  UsersListViewController.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 15.11.2022.
//

import UIKit

struct Constants {
    
    struct Text {
        static let empty = ""
        static let localizableFilename = "Localizable"
        static let infoplistFilename = "Info"
        static let plistExtension = "plist"
        static let contentType = "Content-Type"
        static let applicationJson = "application/json"
    }
    
    struct TimeInterval {
        static let request: Double = 30
    }
    
    struct Size {
        static var appCornerRadius: CGFloat {
            return UIDevice.current.userInterfaceIdiom == .pad ? 10 : 5
        }
        static var borderWidth = 1.0
    }
}
