//
//  BeverageStore.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 03.09.20.
//

import Foundation

protocol BeverageStoreDelegate: class {
    func beverageStoreDidFilterBeverages(_ beverageStore: BeverageStore)
    func beverageStoreDidSortBeverages(_ beverageStore: BeverageStore)
}

final class BeverageStore {
    static let shared = BeverageStore()
    
    private(set) var allBeverages = [Beverage.Article]()
    
    weak var delegate: BeverageStoreDelegate?
    
    private init() {}
    
    func fetchAllBeverages(completion: @escaping (Result<Void, Error>) -> Void) {
        Networker.shared.request(URLRequestFactory.allBeveragesURLRequest()) { result in
            do {
                let decoder = JSONDecoder()
                let beverages = try decoder.decode([Beverage].self, from: try result.get())
                let articles = beverages.flatMap { $0.articles }
                self.allBeverages = articles
                
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func fetchAllBeverageImages(completion: @escaping (Result<[URL], Error>) -> Void) {
        fetchAllBeverages { result in
            do {
                try result.get()
                let images = self.allBeverages.compactMap { $0.image }
                completion(.success(images))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func sortBeverages() {
        allBeverages.sort(by: <)
        delegate?.beverageStoreDidSortBeverages(self)
    }
    
    func filterBeverages() {
        let filteredBeverages = allBeverages.filter { $0.pricePerUnit! < 2.0 }
        allBeverages = filteredBeverages
        delegate?.beverageStoreDidFilterBeverages(self)
    }
}
