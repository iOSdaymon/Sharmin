//
//  Localizable.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 15.11.2022.
//

import Foundation

protocol Localizable {
    var localized: String { get }
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var localized: String {
        return rawValue.localized()
    }
}
