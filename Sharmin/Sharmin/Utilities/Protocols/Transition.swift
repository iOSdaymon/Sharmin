//
//  Transition.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 15.11.2022.
//

import UIKit

protocol Transition: AnyObject {
    var viewController: UIViewController? { get set }
    
    func open(_ viewController: UIViewController,
              completionHandler: (() -> Void)?)
    func rootController(_ navController: UINavigationController)
    func close(_ viewController: UIViewController,
               completionHandler: (() -> Void)?)
}
