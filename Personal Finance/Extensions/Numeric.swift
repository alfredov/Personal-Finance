//
//  Numeric.swift
//  Personal Finance
//
//  Created by Alfredo Villagomez on 2/21/19.
//  Copyright © 2019 Alfredo Villagomez. All rights reserved.
//

import Foundation

extension Numeric {
    func currency() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        guard let formatted = formatter.string(from: self as! NSNumber) else {
            return "\(self)"
        }
        return formatted
    }
}
