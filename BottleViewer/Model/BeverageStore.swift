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
}
