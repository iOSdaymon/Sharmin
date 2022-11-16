//
//  UserPostsModule.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 16.11.2022.
//

import UIKit

final class UserPostsModule {
    var sender: Any?
    
    var transition: Transition {
        return PushTransition()
    }
    
    var user: User
    
    var module: UIViewController {
        
        let router = UserPostsRouter()
        let viewModel = UserPostsViewModel(router: router, user: user)
        let viewController = UserPostsViewController(viewModel: viewModel, router: router)
        
        router.openTransition = transition
        router.viewController = viewController
        
        return viewController
    }
    
    init(sender: Any?, user: User) {
        self.sender = sender
        self.user = user
    }
}
