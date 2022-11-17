//
//  UserPostsViewModel.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 16.11.2022.
//

import Foundation
import RxCocoa
import RxSwift

protocol UserPostsViewModelProtocol: AnyObject {
    
    var posts: BehaviorRelay<[Post]> { set get }
    var imageUrlString: BehaviorRelay<String> { set get }
    
    init(router: UserPostsRouterProtocol, user: User)
    
}

final class UserPostsViewModel: UserPostsViewModelProtocol {
    
    private let router: UserPostsRouterProtocol
    private let user: User
    
    var posts: BehaviorRelay<[Post]>
    var imageUrlString: BehaviorRelay<String>
    
    init(router: UserPostsRouterProtocol, user: User) {
        self.router = router
        self.user = user
        self.posts = BehaviorRelay(value: user.posts ?? [])
        self.imageUrlString = BehaviorRelay(value: user.url)
    }
    
}

// MARK: - Private functions
private extension UserPostsViewModel {
    
}
