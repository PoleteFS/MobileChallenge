//
//  ProductsViewModel.swift
//  MobileChallenfe
//
//  Created by PolSFY on 17/1/23.
//

import Foundation
import UniformTypeIdentifiers


class ProductsViewModel {
    
    //MARK: VARS
    var conversionResponse: [ConversionModel]?
    var transactionResponse: [TransactionProductModel]?
    var products = [String]()
    var eurConversions = [String:Double]()
    
    
    //MARK: CONVERSIONS URL CALL
    func getBadgesConversion(comp: @escaping () -> ()) {
        guard let url =  URL(string: "https://android-ios-service.herokuapp.com/rates") else { return }
        let urlSession = URLSession.shared
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        urlSession.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                print("Ha habido un error \(String(describing: error))")
                return
            }
            
            guard let data = data else {
                print("Datos incorrectos!")
                return
            }
            
            self.conversionResponse = try? JSONDecoder().decode([ConversionModel].self, from: data)
            self.getEURConversion()
            comp()
            
        }.resume()
        
    }

    
    //MARK: TRANSACTIONS URL CALL
    func getProductsTransactions(comp: @escaping () -> ()) {
        
        guard let url =  URL(string: "https://android-ios-service.herokuapp.com/transactions") else { return }
        let urlSession = URLSession.shared
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        urlSession.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                print("Ha habido un error \(String(describing: error))")
                return
            }
            
            guard let data = data else {
                print("Datos Incorrectos!")
                return
            }
            
            self.transactionResponse = try? JSONDecoder().decode([TransactionProductModel].self, from: data)
            self.getDifferentsProducts()
            comp()

        }.resume()
        
    }
    
    
    //MARK: GET ALL SPECIFIC PRODUCT TRANSACTIONS
    func getTransactionRelated(productName: String) -> [TransactionProductModel]? {
        var productTransactions = [TransactionProductModel]()
        guard let transactions = transactionResponse else { return nil }
        for transaction in transactions {
            if transaction.sku == productName {
                productTransactions.append(transaction)
            }
        }
        return  productTransactions
    }
    
    //MARK: GET ALL DIFFERENTS PRODUCTS
    func getDifferentsProducts() {
        guard let transactions = transactionResponse else { return }
        for transaction in transactions {
            if !products.contains(transaction.sku){
                products.append(transaction.sku)
            }
        }
    }
    
    //MARK: GET ALL CURRENCYS TO EUR EQUIVALANCE
    func getEURConversion() {
        guard var conversions = conversionResponse else { return }
        var index = 0
        while conversions.count > 0 {
            if index == conversions.count && index != 0 {
                index = 0
            }
            if conversions[index].from == "EUR" {
                eurConversions[conversions[index].to] = 1/conversions[index].rate
                conversions.remove(at: index)
            }
            else if conversions[index].to == "EUR" {
                eurConversions[conversions[index].from] = conversions[index].rate
                conversions.remove(at: index)
            }
            else if !eurConversions.keys.contains(conversions[index].from) && eurConversions.keys.contains(conversions[index].to) {
                if let lastRate = eurConversions[conversions[index].to] {
                    eurConversions[conversions[index].from] = conversions[index].rate * lastRate
                    conversions.remove(at: index)
                }
            }
            else {
                index += 1
            }     
        }
    }
    
}
