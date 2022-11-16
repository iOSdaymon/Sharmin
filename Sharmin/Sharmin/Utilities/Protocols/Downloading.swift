//
//  Transition.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 15.11.2022.
//

import Foundation
import RxCocoa
import RxSwift

protocol Downloading: AnyObject {
    var loading: PublishSubject<Bool> {get}
    var error : PublishSubject<String> {get}
    
    func downloadData()
}

extension Downloading {
    
    func downloadData() {
        debugPrint("You can implement the function itself")
    }
    
}
