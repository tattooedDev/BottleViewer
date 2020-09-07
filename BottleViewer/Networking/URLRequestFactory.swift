//
//  URLRequestFactory.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 03.09.20.
//

import Foundation

/// The Factory on which we build our URLRequests
struct URLRequestFactory {
    private static let baseURL = "https://flapotest.blob.core.windows.net/test/ProductData.json"
    
    private init() {}
    
    /// Creates a request for fetching all beverages from the API
    /// - Returns: The URLRequest which we pass to the Networker
    static func allBeveragesURLRequest() -> URLRequest {
        let url = URL(string: baseURL)!
        return URLRequest(url: url)
    }
    
    /// Creates a request for all images from a beverage
    /// - Parameter beverage: The Beverage from which we need the images from
    /// - Returns: The URLRequest which we pass to the Networker
    static func imageURLRequest(for beverage: Beverage) -> URLRequest {
        return URLRequest(url: beverage.articles.first!.image)
    }
}
