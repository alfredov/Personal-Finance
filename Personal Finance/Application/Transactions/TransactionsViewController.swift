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
    var components = UI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(components.tableViewCell, forCellReuseIdentifier: "cell")
    }
}

extension TransactionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = 8
        tableView.backgroundView = count == 0 ? components.emptyStateView : nil
        tableView.separatorStyle = count == 0 ? .none : .singleLine
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.amount.text = "$ 12"
        cell.subject.text = "Netflix"
        cell.title.text = "Monthly Subscription"
        cell.date.text = "Fri 7"
        cell.time.text = "5:12 PM"
        cell.avatarImageView.image = UIImage(named: "user2")
        return cell
    }
    
}
