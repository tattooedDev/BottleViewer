//
//  Networker.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 03.09.20.
//

import Foundation

/// The class that will deal with all networking in the app
final class Networker {
    
    /// A custom fallback error for when the request fails with no HTTP status code
    enum NetworkingError: LocalizedError {
        case unknown
        
        var errorDescription: String? {
            switch self {
                case .unknown: return "An unknown error occured. Please try again later."
            }
        }
    }
    
    static let shared = Networker()
    
    private init() {}
    
    /// Executes a URLRequest
    /// - Parameters:
    ///   - urlRequest: The URLRequest to exectute
    ///   - completion: Completes with either the `Data` returned from the API or an `Error`
    func request(_ urlRequest: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let httpResponse = response as? HTTPURLResponse {
                guard httpResponse.statusCode == 200 else {
                    guard let networkError = NetworkError(rawValue: httpResponse.statusCode) else {
                        completion(.failure(NetworkingError.unknown))
                        return
                    }
                    
                    completion(.failure(networkError))
                    return
                }
                
                guard let data = data else { return }
                completion(.success(data))
            }
        }.resume()
    }
}
