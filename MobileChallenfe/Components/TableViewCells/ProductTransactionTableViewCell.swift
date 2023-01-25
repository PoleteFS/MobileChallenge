//
//  ProductTransactionTableViewCell.swift
//  MobileChallenfe
//
//  Created by PolSFY on 19/1/23.
//

import UIKit

class ProductTransactionTableViewCell: UITableViewCell {
    
    //MARK: OUTLETS
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK: TABLEVIEWCELL CONFIGURE FUNC
    public func configure(title: String, amount: String, currency: String) {
        titleLabel.text = title
        amountLabel.text = amount
        currencyLabel.text = currency
    }
    
}
