//
//  TransactionsViewController.swift
//  Personal Finance
//
//  Created by Alfredo Villagomez on 1/21/19.
//  Copyright © 2019 Alfredo Villagomez. All rights reserved.
//

import UIKit

class TransactionsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var loading = true
    var components = UI()
    private var viewModel = TransactionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        viewModel.delegate = self
        tableView.register(components.tableViewCell, forCellReuseIdentifier: "cell")
    }
}

extension TransactionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.numberOfItems
        if loading {
            tableView.backgroundView = UI.LoadingTableView
            tableView.separatorStyle = .none
        } else {
            tableView.backgroundView = count == 0 ? components.emptyStateView : nil
            tableView.separatorStyle = count == 0 ? .none : .singleLine
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.viewModel = viewModel.item(at: indexPath)
        return cell
    }
    
}

extension TransactionsViewController: TransactionsViewModelDelegate {
    func didLoadData() {
        loading = false
        tableView.reloadData()
    }
}
