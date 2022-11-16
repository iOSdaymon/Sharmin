//
//  Reactive+Extension.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 15.11.2022.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    
    /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
    public var isAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (vc, active) in
            if active {
                vc.startAnimating()
            } else {
                vc.stopAnimating()
            }
        })
    }
    
}
