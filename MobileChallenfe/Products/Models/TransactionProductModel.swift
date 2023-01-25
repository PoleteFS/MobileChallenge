//
//  TransactionProductModel.swift
//  MobileChallenfe
//
//  Created by PolSFY on 17/1/23.
//

import Foundation




struct TransactionProductModel: Decodable {
    let amount: Double
    let currency: String
    var sku: String
    
    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case currency = "currency"
        case sku = "sku"
    }
}
