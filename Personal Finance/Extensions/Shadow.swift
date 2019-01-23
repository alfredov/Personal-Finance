//
//  Shadow.swift
//  Personal Finance
//
//  Created by Alfredo Villagomez on 1/23/19.
//  Copyright © 2019 Alfredo Villagomez. All rights reserved.
//

import UIKit

extension UIView {
    var borderUIColor: UIColor {
        get {
            guard let color = layer.borderColor else {
                return UIColor.black
            }
            return UIColor(cgColor: color)
        }
        
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}
