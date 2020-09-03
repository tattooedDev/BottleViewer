//
//  URLRequestFactory.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 03.09.20.
//

import Foundation

struct URLRequestFactory {
    private static let baseURL = "https://flapotest.blob.core.windows.net/test/ProductData.json"
    
    private init() {}
    
    static func allBeveragesURLRequest() -> URLRequest {
        let url = URL(string: baseURL)!
        return URLRequest(url: url)
    }
    
    static func imageURLRequest(for beverage: Beverage) -> URLRequest {
        return URLRequest(url: beverage.articles.first!.image)
    }
}
