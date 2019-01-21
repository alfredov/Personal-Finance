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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UI.getTableViewCell(), forCellReuseIdentifier: "cell") 
    }
}

extension TransactionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
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
