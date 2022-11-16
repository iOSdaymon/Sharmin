//
//  UsersListModule.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 16.11.2022.
//

import UIKit

final class UsersListModule {
    var sender: Any?
    
    var transition: Transition {
        return PushTransition()
    }
    
    var module: UIViewController {
        
        let router = UsersListRouter()
        let viewModel = UsersListViewModel(router: router)
        let viewController = UsersListViewController(viewModel: viewModel, router: router)
        
        router.openTransition = transition
        router.viewController = viewController
        
        return viewController
    }
    
    init(sender: Any?) {
        self.sender = sender
    }
}
