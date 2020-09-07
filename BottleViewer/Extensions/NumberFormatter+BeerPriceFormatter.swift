//
//  NumberFormatter+BeerPriceFormatter.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 04.09.20.
//

import Foundation

extension NumberFormatter {
    /// Formats the article's price so only the decimal number remains
    static var beerPriceFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "de_DE")
        numberFormatter.numberStyle = .decimal

        let currencySymbol: String = numberFormatter.currencySymbol
        numberFormatter.positivePrefix = "("
        numberFormatter.negativePrefix = "("
        numberFormatter.positiveSuffix = " \(currencySymbol)/Liter)"
        numberFormatter.negativeSuffix = " \(currencySymbol)/Liter)"
        
        return numberFormatter
    }
}
