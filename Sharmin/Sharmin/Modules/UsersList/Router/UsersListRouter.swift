//
//  UsersListRouter.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 16.11.2022.
//

import Foundation

protocol UsersListRouterProtocol: AnyObject {
    func openPosts(for user: User)
}

final class UsersListRouter: AppNavigationRouter<UsersListViewController>, UsersListRouterProtocol {
    
    func openPosts(for user: User) {
        let module = UserPostsModule.init(sender: nil, user: user)
        open(module.module, transition: module.transition)
    }
}
