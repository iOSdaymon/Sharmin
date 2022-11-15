//
//  String+Extension.swift
//  Sharmin
//
//  Created by Dima Sviderskyi on 15.11.2022.
//

import UIKit

extension String {
    
    func localized(bundle: Bundle = .main,
                   tableName: String = Constants.Text.localizableFilename) -> String {
        return NSLocalizedString(self, tableName: tableName, value: self, comment: Constants.Text.empty)
    }
}

