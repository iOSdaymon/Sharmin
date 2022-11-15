//
//  BaseViewController.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 15.11.2022.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Private functions
private extension BaseViewController {
    
    func configureUI() {
        
    }
}
