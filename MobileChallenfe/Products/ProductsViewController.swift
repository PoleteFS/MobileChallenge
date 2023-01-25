//
//  ViewController.swift
//  MobileChallenfe
//
//  Created by PolSFY on 17/1/23.
//

import UIKit

class ProductsViewController: UIViewController{
    
    //MARK: VARS AND OUTLETS
    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var notBlockedInterfaceButton: UIButton!
    @IBOutlet weak var button: UIButton!
    
    var viewModel = ProductsViewModel()
    var isDataLoad: Bool? = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !(isDataLoad ?? false) {
            isDataLoad = true
            getData()
        }
    }
        
    //MARK: GET ALL APP DATA
    func getData() {
        getBadgesConversion()
        getProductsTransactions()
    }
    
    //MARK: GET CONVERSIONS DATA
    private func getBadgesConversion() {
        viewModel.getBadgesConversion(comp: {
            DispatchQueue.main.async {
                self.productsTableView.reloadData()
            }
        })
    }
    
    //MARK: VERIFY NOT BLOQUED UI BUTTON TAPPED
    @IBAction func bottomButtonTap(_ sender: Any) {
        print("Interície de uusario NO bloqueada!!")
    }
    
    //MARK: GET TRANSACTIONS DATA
    private func getProductsTransactions() {
        viewModel.getProductsTransactions(comp: {
            DispatchQueue.main.async {
                self.productsTableView.reloadData()
            }
        })
    }
    
    //MARK: SETUP GENERAL UI
    private func setupUI() {
        title = "Productos"
        titleLabel.text = "Lista de productos"
        notBlockedInterfaceButton.setTitle("INTERFÍCIE NO BLOQUEADA", for: .normal)
        notBlockedInterfaceButton.layer.cornerRadius = 10
        setupTableViewUI()
    }
    
    //MARK: SETUP TABLEVIEW UI
    private func setupTableViewUI() {
        productsTableView.delegate = self
        productsTableView.dataSource = self
        productsTableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
    }

}

//MARK: TABLE VIEW CONFIGURATION AND CONTENT SET UP
extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as?  ProductTableViewCell{
            let model = viewModel.products[indexPath.row]
            cell.configure(productName: model, delegate: self)
            cell.detailButton.tag = indexPath.row
            cell.tag = indexPath.row
            return cell
        }
        return UITableViewCell()
    }
    
}

//MARK: TABLEVIEW CELL DELEGATE IMPLEMENTATIONS
extension ProductsViewController: ProductTableViewCellDetailClickDelegate {
    func didButtonClick(sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController {
            vc.viewModel.transactions = viewModel.getTransactionRelated(productName: viewModel.products[sender.tag])
            vc.viewModel.eurConversions = viewModel.eurConversions
            vc.product = viewModel.products[sender.tag]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

