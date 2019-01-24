//
//  BudgetViewController.swift
//  Personal Finance
//
//  Created by Alfredo Villagomez on 1/23/19.
//  Copyright © 2019 Alfredo Villagomez. All rights reserved.
//

import UIKit

class BudgetViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var animationsButton: [UIButton]!
    @IBOutlet weak var animationLayout: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        var ui = UI()
        tableView.register(ui.tableViewCell, forCellReuseIdentifier: "cell")
    }
    
    @IBAction func animation(sender: UIButton) {
        animationLayout.constant = sender.frame.origin.x
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        }) { (completed) in
            self.animationsButton.forEach {
                $0.setTitleColor(UIColor(named: "TextColor"), for: .normal)
            }
            sender.setTitleColor(UIColor.white, for: .normal)
        }
    }

}

extension BudgetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.amount.text = "$ 1500"
        cell.subject.text = "Salary"
        cell.title.text = "Monthly salary"
        cell.date.text = "Wed 34"
        cell.time.text = "4:30 PM"
        cell.avatarImageView.image = UIImage(named: "user1")
        return cell
    }
    
}
