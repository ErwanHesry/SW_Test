//
//  StringExtensions.swift
//
//  Created by Erwan Hesry on 24/06/2020.
//  Copyright © 2020 Erwan Hesry. All rights reserved.
//

import Foundation

extension String {
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localize(_ inTable:String) -> String {
        return NSLocalizedString(self, tableName: inTable, bundle: Bundle.main, value: "", comment: "")
    }
    
    func localizeWithFormat(inTable:String?, _ arguments: CVarArg...) -> String{
        if let inTable = inTable {
            return String(format: localize(inTable), arguments: arguments)
        } else {
            return String(format: localize(), arguments: arguments)
        }
    }
}
