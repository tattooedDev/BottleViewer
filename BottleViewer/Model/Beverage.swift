//
//  Beverage.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 03.09.20.
//

import Foundation

struct Beverage: Codable, Hashable {
    struct Article: Codable, Hashable {
        let id: Int
        let shortDescription: String
        let price: Double
        let unit: String
        let pricePerUnitText: String
        let image: URL
        
        var formattedPrice: String? {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .currency
            numberFormatter.locale = Locale(identifier: "de_DE")
            return numberFormatter.string(from: price as NSNumber)
        }
        
        var pricePerUnit: Double? {
            return NumberFormatter.beerPriceFormatter.number(from: pricePerUnitText)?.doubleValue
        }
    }
    
    let id: Int
    let brandName: String
    let name: String
    let descriptionText: String?
    let articles: [Article]
}

extension Beverage.Article: Comparable {
    static func < (lhs: Beverage.Article, rhs: Beverage.Article) -> Bool {
        return lhs.price < rhs.price
    }
    
    static func == (lhs: Beverage.Article, rhs: Beverage.Article) -> Bool {
        lhs.id == rhs.id
    }
}

extension Beverage: Comparable {
    static func < (lhs: Beverage, rhs: Beverage) -> Bool {
        return lhs.articles[0].price < rhs.articles[0].price
    }
}
