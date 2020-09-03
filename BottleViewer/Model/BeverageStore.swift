//
//  BeverageStore.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 03.09.20.
//

import Foundation

final class BeverageStore {
    func fetchAllBeverages(completion: @escaping (Result<[Beverage], Error>) -> Void) {
        Networker.shared.request(URLRequestFactory.allBeveragesURLRequest()) { result in
            do {
                let decoder = JSONDecoder()
                let beverages = try decoder.decode([Beverage].self, from: try result.get())
                completion(.success(beverages))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func fetchAllBeverageImages(completion: @escaping (Result<[URL], Error>) -> Void) {
        fetchAllBeverages { result in
            do {
                let beverages = try result.get()
                let images = beverages.flatMap { $0.articles.compactMap { $0.image } }
                completion(.success(images))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
