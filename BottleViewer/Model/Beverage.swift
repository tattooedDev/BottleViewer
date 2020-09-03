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
        let pricePerUnit: String?
        let image: URL
        
        var formattedPrice: String? {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .currency
            numberFormatter.locale = .current
            return numberFormatter.string(from: price as NSNumber)
        }
    }
    
    let id: Int
    let brandName: String
    let name: String
    let descriptionText: String?
    let articles: [Article]
}
