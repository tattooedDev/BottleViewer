//
//  Networker.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 03.09.20.
//

import Foundation

final class Networker {
    enum NetworkingError: Error {
        case unknown
    }
    
    static let shared = Networker()
    
    private init() {}
    
    func request(_ urlRequest: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    completion(.failure(NetworkingError.unknown))
                    return
                }
                
                completion(.success(data))
            }
        }.resume()
    }
}
