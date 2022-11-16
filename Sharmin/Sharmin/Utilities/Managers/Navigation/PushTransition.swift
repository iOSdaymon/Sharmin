//
//  PushTransition.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 15.11.2022.
//


import UIKit

final class PushTransition: NSObject {
    
    private var animator: Animator?
    private var isAnimated: Bool = true
    
    private var modalTransitionStyle: UIModalTransitionStyle
    private var modalPresentationStyle: UIModalPresentationStyle
    
    weak var viewController: UIViewController?
    
    deinit {
        viewController = nil
        animator = nil
    }
    
    init(/// Default is nil
        animator: Animator? = nil,
        /// Default is true
        isAnimated: Bool = true,
        /// Default is .coverVertical
        modalTransitionStyle: UIModalTransitionStyle = .coverVertical,
        /// Default is .fullScreen
        modalPresentationStyle: UIModalPresentationStyle = .fullScreen) {
        
        self.animator = animator
        self.isAnimated = isAnimated
        self.modalTransitionStyle = modalTransitionStyle
        self.modalPresentationStyle = modalPresentationStyle
    }
}

// MARK: - Transition
extension PushTransition: Transition {
    
    func open(_ viewController: UIViewController,
              completionHandler: (() -> Void)? = nil) {
        viewController.modalTransitionStyle = modalTransitionStyle
        viewController.modalPresentationStyle = modalPresentationStyle
        self.viewController?.navigationController?.delegate = self
        self.viewController?.navigationController?.pushViewController(viewController, animated: isAnimated, completion: completionHandler)
    }
    
    func rootController(_ navController: UINavigationController) {
        let navigationController = navController
        navigationController.isNavigationBarHidden = true
        UIApplication.shared.delegate?.window??.rootViewController = navigationController
    }
    
    func close(_ viewController: UIViewController, completionHandler: (() -> Void)?) {
        viewController.navigationController?.popViewController(animated: isAnimated)
        completionHandler?()
    }
    
}

// MARK: - UINavigationControllerDelegate
extension PushTransition: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let animator = animator else {
            return nil
        }
        if operation == .push {
            animator.isPresenting = true
            return animator
        }
        else {
            animator.isPresenting = false
            return animator
        }
    }
    
}
