//
//  UserPostsViewModel.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 16.11.2022.
//

import Foundation

protocol UserPostsViewModelOutput: AnyObject {
    
    
}

protocol UserPostsViewModelProtocol: AnyObject {
    
    var user: User { get }
    var output: UserPostsViewModelOutput? {set get}
    
    init(router: UserPostsRouterProtocol, user: User)
    
}

final class UserPostsViewModel: UserPostsViewModelProtocol {
    
    private let router: UserPostsRouterProtocol
    
    var user: User
    weak var output: UserPostsViewModelOutput?
    
    init(router: UserPostsRouterProtocol, user: User) {
        self.router = router
        self.user = user
    }
    
}

// MARK: - Private functions
private extension UserPostsViewModel {
    
}

// MARK: - UserPostsViewModelProtocol
extension UserPostsViewModel {
    
    
}

// MARK: - Network Requests
extension UserPostsViewModel {
    
    func downloadData() {
        
        
    }
    
}
