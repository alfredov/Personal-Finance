//
//  UI.swift
//  Personal Finance
//
//  Created by Alfredo Villagomez on 1/21/19.
//  Copyright © 2019 Alfredo Villagomez. All rights reserved.
//
import UIKit

enum UINamed: String {
    case TableViewCell
    case EmptyView
}

struct UI {
    static public func getTableViewCell() -> UINib {
        return UINib(nibName: UINamed.TableViewCell.rawValue, bundle: Bundle.main)
    }
}
