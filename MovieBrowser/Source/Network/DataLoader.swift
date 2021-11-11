//
//  DataLoader.swift
//  MovieBrowser
//
//  Created by Einstein Nguyen on 11/10/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

protocol NetworkEngine {
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    func performRequest(for url: URL, completionHandler: @escaping Handler)
}

class DataLoader {
    enum Result {
        case data(Data)
        case error(Error)
    }
    
    private let engine: NetworkEngine
    
    init(engine: NetworkEngine = URLSession.shared) {
        self.engine = engine
    }
    
    func load(from url: URL, completionHandler: @escaping (Result) -> Void) {
        engine.performRequest(for: url) { (data, _, error) in
            if let error = error {
                return completionHandler(.error(error))
            }
            completionHandler(.data(data ?? Data()))
        }
    }
}

extension URLSession: NetworkEngine {
    typealias Handler = NetworkEngine.Handler
    
    func performRequest(for url: URL, completionHandler: @escaping Handler) {
        let task = dataTask(with: url, completionHandler: completionHandler)
        task.resume()
    }
}
