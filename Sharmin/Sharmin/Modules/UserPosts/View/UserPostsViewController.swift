//
//  UserPostsViewController.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 16.11.2022.
//

import UIKit
import RxSwift
import RxCocoa

class UserPostsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    private var imageView = UIImageView()
    
    private let viewModel: UserPostsViewModelProtocol
    private let router: UserPostsRouterProtocol
    
    private let disposeBag = DisposeBag()
    
    init(viewModel: UserPostsViewModelProtocol, router: UserPostsRouterProtocol) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Required init error" + "\(Self.self)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        
        tableView.register(UINib(nibName: PostsListCell.reuseIdentifier, bundle: nil),
                           forCellReuseIdentifier: PostsListCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        
        imageView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: Constants.Size.deviceWidth,
                                 height: Constants.Size.deviceHeight*0.2)
        imageView.contentMode = .scaleAspectFit
        tableView.tableHeaderView = imageView
    }
    
    func subscribe() {
        
        viewModel.posts
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier:  PostsListCell.reuseIdentifier, cellType:  PostsListCell.self)) { (row, post, cell) in
                cell.update(with: post)
            }
            .disposed(by: disposeBag)
        
        viewModel.imageUrlString
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] imageUrlString in
                guard let self = self else {return}
                self.imageView.set(imageUrlString)
            })
            .disposed(by: disposeBag)
    }
}
