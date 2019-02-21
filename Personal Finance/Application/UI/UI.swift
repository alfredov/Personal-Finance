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
    case LoadingTableView
}

struct UI {
    public lazy var emptyStateView: UIView = {
        guard let view = Bundle.main.loadNibNamed(UINamed.EmptyView.rawValue, owner: nil, options: [:])?.first as? UIView else {
            return UIView()
        }
        return view
    }()
    
    public lazy var tableViewCell: UINib? = {
        guard let cell = UINib(nibName: UINamed.TableViewCell.rawValue, bundle: Bundle.main) as? UINib else {
            return nil
        }
        return cell
    }()
    
    public static let LoadingTableView: UIView = {
        guard let view = Bundle.main.loadNibNamed(UINamed.LoadingTableView.rawValue, owner: nil, options: [:])?.first as? UIView else {
            return UIView()
        }
        return view
    }()
}
