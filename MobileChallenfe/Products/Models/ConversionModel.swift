//
//  ConversionModel.swift
//  MobileChallenfe
//
//  Created by PolSFY on 17/1/23.
//

import Foundation


struct ConversionModel: Decodable {
    let from: String
    let rate: Double
    let to: String
    
    
    enum CodingKeys: String, CodingKey {
        case from = "from"
        case rate = "rate"
        case to = "to"
    }
    
}
