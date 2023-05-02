//
//  HelperFunctions.swift
//  MarketMall
//
//  Created by Ваня Науменко on 2.05.23.
//

import Foundation


func convertToCurrency(_ number: Double) -> String {
    
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
    currencyFormatter.locale = Locale.current
     
    return currencyFormatter.string(from: NSNumber(value: number))!
}
