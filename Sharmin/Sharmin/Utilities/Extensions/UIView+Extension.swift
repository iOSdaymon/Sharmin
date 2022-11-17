//
//  UIView+Extension.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 15.11.2022.
//

import UIKit

extension UIView {
    
    func round() {
        let width = bounds.width < bounds.height ? bounds.width : bounds.height
        let mask = CAShapeLayer()
        mask.path = UIBezierPath(ovalIn: CGRectMake(bounds.midX - width / 2, bounds.midY - width / 2, width, width)).cgPath
        layer.mask = mask
    }
}
