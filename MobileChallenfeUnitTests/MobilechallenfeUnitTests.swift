//
//  ProductsUnitTests.swift
//  ProductsUnitTests
//
//  Created by PolSFY on 24/1/23.
//

import XCTest
@testable import MobileChallenfe

final class ProductsUnitTests: XCTestCase {
    
    //MARK: UNIT TEST TO VERIFY A FALSE PRODUCT
    func test_No_Transactions_Product_Related() {
        let productsVM = ProductsViewModel()
        let falseTransactionProducts =  productsVM.getTransactionRelated(productName: "TEST")
        XCTAssertEqual(falseTransactionProducts?.count, nil)
    }
    
    //MARK: UNIT TEST TO VERIFY AND IMPOSIBLE CONVERSION
    func test_Correct_Eur_Conversions() {
        let c1 = ConversionModel(from: "EUR", rate: 1.1, to: "USD")
        let c2 = ConversionModel(from: "RTE", rate: 1.1, to: "EUR")
        let c3 = ConversionModel(from: "BDR", rate: 1.1, to: "INR")
        let c4 = ConversionModel(from: "INR", rate: 1.1, to: "EUR")
        
        var conversionRes = [ConversionModel]()
        conversionRes.append(c1)
        conversionRes.append(c2)
        conversionRes.append(c3)
        conversionRes.append(c4)
        
        let productsVM = ProductsViewModel()
        productsVM.conversionResponse = conversionRes
        let expectation = XCTestExpectation(description: "timeout")
        let task = Task {
            try await productsVM.getEURConversion()
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
        task.cancel()
    }
    
    //MARK: TEST TO VERIFY A NIL RATE CURRENCY CONVERSION
    func test_Not_Rate_Currency_Data_Exists() {
        let productDetailVM = ProductDetailViewModel()
        let rate = productDetailVM.getRateCurrencyToEurConversion(productCurrency: "AAA")
        XCTAssertEqual(rate, nil)
    }

}
