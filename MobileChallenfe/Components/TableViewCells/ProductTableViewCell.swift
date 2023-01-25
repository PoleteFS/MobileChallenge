//
//  ProductTableViewCell.swift
//  MobileChallenfe
//
//  Created by PolSFY on 18/1/23.
//

import UIKit

protocol ProductTableViewCellDetailClickDelegate {
    func didButtonClick(sender: UIButton)
}


class ProductTableViewCell: UITableViewCell {

    //MARK: VARS AND OUTLETS
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var productName: UILabel!
    
    private var delegate: ProductTableViewCellDetailClickDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: TABLEVIEWCELL CONFIGURE FUNC
    public func configure(productName: String, delegate: ProductTableViewCellDetailClickDelegate?) {
        self.productName.text = productName
        self.delegate = delegate
    }
    
    //MARK: TABLEVIEWCELL BUTTON TAP FUNCTION
    @IBAction func buttonTap(_ sender: UIButton) {
        delegate?.didButtonClick(sender: sender)
    }
}
