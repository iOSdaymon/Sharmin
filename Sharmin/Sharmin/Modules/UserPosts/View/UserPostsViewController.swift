//
//  UserPostsViewController.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 16.11.2022.
//

import UIKit

class UserPostsViewController: UIViewController {

    private let viewModel: UserPostsViewModelProtocol
    private let router: UserPostsRouterProtocol
    
    init(viewModel: UserPostsViewModelProtocol, router: UserPostsRouterProtocol) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: String(describing: Self.self), bundle: nil)
        self.viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("Required init error" + "\(Self.self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    override func loadView() {
        super.loadView()
        subscribe()
    }
}

// MARK: - Private functions
private extension UserPostsViewController {
    
    func configureUI() {
        
        title = KeysForTranslate.userPostsTitle.localized
        
    }
    
    func subscribe() {
        
    }
}
// MARK: - UserPostsViewModelOutput
extension UserPostsViewController: UserPostsViewModelOutput {
    
    
}
