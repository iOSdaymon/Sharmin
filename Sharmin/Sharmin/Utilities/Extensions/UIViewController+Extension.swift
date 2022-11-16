//
//  UIViewController+Extension.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 15.11.2022.
//

import UIKit
import SVProgressHUD

extension UIViewController {
    
    func showErrorAlert(message: String? = nil,
                        completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: KeysForTranslate.failed.localized,
                                      message: message,
                                      preferredStyle: .alert)
        self.present(alert, animated: false)
    }
    
    func startAnimating() {
        SVProgressHUD.show()
    }
    
    func stopAnimating() {
        SVProgressHUD.dismiss()
    }
    
}
