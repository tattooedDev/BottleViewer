//
//  Beverage.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 03.09.20.
//

import Foundation

struct Beverage: Codable {
    struct Article: Codable {
        let id: Int
        let shortDescription: String
        let price: Double
        let unit: String
        let pricePerUnitText: String?
        let image: URL
        
        var formattedPrice: String? {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .currency
            numberFormatter.locale = .current
            return numberFormatter.string(from: price as NSNumber)
        }
        
        var pricePerUnit: Double? {
            guard let pricePerUnitText = pricePerUnitText else { return nil }
            let pricePerUnitString = pricePerUnitText.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: " €/Liter", with: "").replacingOccurrences(of: ",", with: ".")
            let pricePerUnit = Double(pricePerUnitString)
            return pricePerUnit
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
