//
//  StringsHelper.swift
//  NYCSchools
//
//  Created by Emerson Siega on 07/10/24.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(params: CVarArg...) -> String {
        return String(format: localized(), params)
    }
}
