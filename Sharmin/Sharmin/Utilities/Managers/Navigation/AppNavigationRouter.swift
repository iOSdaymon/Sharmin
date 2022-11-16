//
//  AppNavigationRouter.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 15.11.2022.
//

import UIKit

protocol AppNavigationRouterProtocol: AnyObject {
    associatedtype V: UIViewController
    var viewController: V? { get }
    
    func open(_ viewController: UIViewController,
              transition: Transition,
              completion: (() -> Void)?)
    func rootController(_ navController: UINavigationController, transition: Transition)
}

open class AppNavigationRouter<U>: AppNavigationRouterProtocol, Closable where U: UIViewController {
    
    typealias V = U
    
    weak var viewController: V?
    var openTransition: Transition?
    
    func open(_ viewController: UIViewController,
              transition: Transition,
              completion: (() -> Void)? = nil) {
        transition.viewController = self.viewController
        transition.open(viewController, completionHandler: completion)
    }
    
    func rootController(_ navController: UINavigationController, transition: Transition) {
        transition.rootController(navController)
    }
    
    func close(completionHandler: (() -> Void)?) {
        guard let openTransition = openTransition else {
            assertionFailure("You should specify an open transition in order to close a module.")
            return
        }
        guard let viewController = viewController else {
            assertionFailure("Nothing to close.")
            return
        }
        openTransition.close(viewController, completionHandler: {
            completionHandler?()
        })
    }
}
