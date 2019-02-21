//
//  TableViewCell.swift
//  Personal Finance
//
//  Created by Alfredo Villagomez on 1/21/19.
//  Copyright © 2019 Alfredo Villagomez. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var viewModel: TransactionViewModel! {
        didSet {
            setupView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView() {
        amount.text = viewModel.value
        subject.text = "Netflix"
        title.text = viewModel.name
        date.text = viewModel.date
        time.text = viewModel.time
        avatarImageView.image = UIImage(named: "user2")
    }

}
