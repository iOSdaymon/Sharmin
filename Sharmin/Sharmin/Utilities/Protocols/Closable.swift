//
//  Closable.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 15.11.2022.
//

import Foundation

protocol Closable: AnyObject {
    func close(completionHandler: (() -> Void)?)
}
