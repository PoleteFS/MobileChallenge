//
//  ProductDetailViewController.swift
//  MobileChallenfe
//
//  Created by PolSFY on 17/1/23.
//

import UIKit


class ProductDetailViewController: UIViewController {
    
    //MARK: VARS AND OUTLETS
    @IBOutlet weak var totalAmountTitleLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var transactionsTableView: UITableView!
    @IBOutlet weak var productTransactionsTitleLabel: UILabel!
    @IBOutlet weak var productDetailTableView: UITableView!
    
    var product: String?
    var viewModel = ProductDetailViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: GENERAL SETUI FUNCTION
    private func setupUI() {
        setupLabels()
        setupTableViewUI()
    }
    
    //MARK: SETUP LABELS TEXTS
    private func setupLabels() {
        productTransactionsTitleLabel.text = "Transacciones de: \(product ?? "")"
        totalAmountTitleLabel.text = "Total: "
        totalAmountLabel.text = viewModel.getTotalAmount()
    }
    
    //MARK: SETUP TABLEVIEW UI
    private func setupTableViewUI() {
        transactionsTableView.delegate = self
        transactionsTableView.dataSource = self
        productDetailTableView.register(UINib(nibName: "ProductTransactionTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTransactionTableViewCell")
    }
    
}

//MARK: TABLE VIEW CONFIGURATION AND CONTENT SET UP
extension ProductDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.transactions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTransactionTableViewCell", for: indexPath) as? ProductTransactionTableViewCell{
            let correctFormatAmount = CurrencyUtils.currencyFormat(num: viewModel.transactions?[indexPath.row].amount ?? 0.0)
            cell.configure(title: "T\(indexPath.row + 1): ",amount: correctFormatAmount , currency: viewModel.transactions?[indexPath.row].currency ?? "")
            return cell
        }
        return UITableViewCell()
    }
    
    
}
