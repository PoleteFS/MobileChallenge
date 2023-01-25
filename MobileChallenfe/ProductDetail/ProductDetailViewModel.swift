//
//  ProductDetailViewModel.swift
//  MobileChallenfe
//
//  Created by PolSFY on 17/1/23.
//

import Foundation



class ProductDetailViewModel {
    
    //MARK: VARS
    var eurConversions = [String:Double]()
    var transactions: [TransactionProductModel]?
    
    //MARK: GET ALL TRANSACTIONS AMOUNT
    func getTotalAmount() -> String {
        guard let productTransactions = transactions else { return "" }
        var totalAmount = Double()
        for transaction in productTransactions {
            if transaction.currency == "EUR" {
                totalAmount += transaction.amount
            }
            else {
                let rate = getRateCurrencyToEurConversion(productCurrency: transaction.currency) ?? 0.0
                totalAmount += CurrencyUtils.twoDecimalsRoundedDouble(num: transaction.amount * rate)
            }
        }
        let twoDecimalsFormat = CurrencyUtils.twoDecimalsRoundedDouble(num: totalAmount)
        return CurrencyUtils.currencyFormat(num: twoDecimalsFormat) + " EUR"
    }
    
    //MARK: GET SPECIFIED RATE TO EUR CONVERSION
    func getRateCurrencyToEurConversion(productCurrency: String) -> Double? {
        if let rate = eurConversions[productCurrency] {
            return rate
        }
        return nil
    }
    
}
