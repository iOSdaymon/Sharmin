//
//  UsersListViewController.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 15.11.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class UsersListViewController: BaseViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel: UsersListViewModelProtocol
    private let router: UsersListRouterProtocol
    
    private let disposeBag = DisposeBag()
    
    init(viewModel: UsersListViewModelProtocol, router: UsersListRouterProtocol) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: String(describing: Self.self), bundle: nil)
        self.viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("Required init error" + "\(Self.self)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.downloadData()
    }
    
    override func loadView() {
        super.loadView()
        subscribe()
    }
    
}
// MARK: - Private functions
private extension UsersListViewController {
    
    func configureUI() {
        
        title = KeysForTranslate.usersListTitle.localized
        
        tableView.register(UINib(nibName: UsersListCell.reuseIdentifier, bundle: nil),
                           forCellReuseIdentifier: UsersListCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func subscribe() {
        
        viewModel.loading
            .bind(to: self.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.error
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] errorDescription in
                guard let self = self else {return}
                guard let message = errorDescription.element else {return}
                self.showErrorAlert(message: message)
            }
            .disposed(by: disposeBag)
        
        viewModel.users
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier:  UsersListCell.reuseIdentifier, cellType:  UsersListCell.self)) { (row, user, cell) in
                cell.update(with: user)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                self.tableView.deselectRow(at: indexPath, animated: true)
                guard let cell = self.tableView.cellForRow(at: indexPath) as? UsersListCell,
                let userId = cell.userId else { return }
                self.viewModel.didSelectUser(with: userId)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UsersListViewModelOutput
extension UsersListViewController: UsersListViewModelOutput {
    
    
}
