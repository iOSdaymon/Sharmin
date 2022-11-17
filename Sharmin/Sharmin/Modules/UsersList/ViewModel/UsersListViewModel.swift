//
//  UsersListViewModel.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 16.11.2022.
//

import Foundation
import RxCocoa
import RxSwift

protocol UsersListViewModelOutput: AnyObject {
    
    
}

protocol UsersListViewModelProtocol: Downloading {
    
    var output: UsersListViewModelOutput? {set get}
    var users: BehaviorRelay<[User]> { set get }
    
    init(router: UsersListRouterProtocol)
}

final class UsersListViewModel: UsersListViewModelProtocol {
    
    private let router: UsersListRouterProtocol
    private let taskGroup = DispatchGroup()
    
    private var postsDict: [Int:[Post]] = [:]
    
    weak var output: UsersListViewModelOutput?
    var users: BehaviorRelay<[User]>
    
    var loading: PublishSubject<Bool>
    var error : PublishSubject<String>
    
    init(router: UsersListRouterProtocol) {
        self.router = router
        self.users = BehaviorRelay(value: [])
        self.loading = PublishSubject()
        self.error = PublishSubject()
    }
    
}

// MARK: - Private functions
private extension UsersListViewModel {
    
}

// MARK: - UsersListViewModelProtocol
extension UsersListViewModel {
    
    func downloadData() {
        getUsers()
        getPosts()
        taskGroup.notify(queue: .main) { [weak self] in
            guard let self = self else {return}
            self.loading.onNext(false)
            self.mountUserPosts()
        }
    }
    
    func getUsers() {
        
        taskGroup.enter()
        loading.onNext(true)
        
        NetworkManager.shared.fetch(route: .getUsers,
                                    completion: { [weak self] (result: Result<[User], APIError>) in
                                        guard let self = self else {return}
                                        self.taskGroup.leave()
                                        
                                        switch result {
                                        case .success(let model):
                                            self.users.accept(model)
                                        case .failure(let error):
                                            self.error.onNext(error.description.customDescription)
                                        }
                                    })
    }
    
    func getPosts() {
        
        taskGroup.enter()
        loading.onNext(true)
        
        NetworkManager.shared.fetch(route: .getPosts,
                                    completion: { [weak self] (result: Result<[Post], APIError>) in
                                        guard let self = self else {return}
                                        self.taskGroup.leave()
                                        
                                        switch result {
                                        case .success(let model):
                                            self.postsDict = Dictionary(grouping: model) { $0.userId }
                                        case .failure(let error):
                                            self.error.onNext(error.description.customDescription)
                                        }
                                    })
    }
    
    func mountUserPosts() {
        var updateUsers = users.value
        updateUsers.indices.forEach {
            updateUsers[$0].posts = postsDict[updateUsers[$0].userId]
        }
        users.accept(updateUsers)
    }
}

