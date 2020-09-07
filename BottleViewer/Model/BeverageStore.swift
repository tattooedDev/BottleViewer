//
//  BeverageStore.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 03.09.20.
//

import Foundation

/// The class responsible for fetching the beverages and preparing them for the caller
final class BeverageStore {
    static let shared = BeverageStore()
    
    private init() {}
    
    func fetchAllBeverages(completion: @escaping (Result<[Beverage], Error>) -> Void) {
        Networker.shared.request(URLRequestFactory.allBeveragesURLRequest()) { result in
            let decoder = JSONDecoder()
            completion(Result { try decoder.decode([Beverage].self, from: try result.get()) })
        }
    }
    
    func sortedBeverages(_ beverages: [Beverage]) -> [Beverage] {
        return beverages.sorted { first, second -> Bool in
            for firstArticle in first.articles {
                for secondArticle in second.articles {
                    if firstArticle.price < secondArticle.price {
                        return true
                    }
                }
            }
            return false
        }
    }
    
    func filteredBeverages(_ beverages: [Beverage]) -> [Beverage] {
        return beverages.filter { beverage -> Bool in
            for article in beverage.articles {
                if article.pricePerUnit! < 2 {
                    return true
                }
            }
            return false
        }
    }
}
