//
//  CurrencyUtils.swift
//  MobileChallenfe
//
//  Created by PolSFY on 20/1/23.
//

import Foundation


class CurrencyUtils {
    
    
    //MARK: GET TWO DECIMALS ROUNDED
    static func twoDecimalsRoundedDouble(num: Double) -> Double {
        let finalNum = round(num * 100) / 100
        return finalNum
    }
    
    //MARK: GET CURREMCY FORMAT
    static func currencyFormat(num: Double)  -> String{
         let currencyFormatter = NumberFormatter()
         currencyFormatter.usesGroupingSeparator = true
         currencyFormatter.numberStyle = .currency
         currencyFormatter.currencySymbol = ""
         let priceString = currencyFormatter.string(from: NSNumber(value: num))!
         return priceString
    }
    
}
