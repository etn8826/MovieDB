//
//  NetworkEngineTest.swift
//  MovieBrowserTests
//
//  Created by Einstein Nguyen on 11/10/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation
import XCTest
@testable import MovieBrowser

class NetworkEngineTest: XCTestCase {
    
    func testLoadingData() {
        class NetworkEngineMock: NetworkEngine {
            typealias Handler = NetworkEngine.Handler
            
            var requestedURL: URL?
            
            func performRequest(for url: URL, completionHandler: @escaping Handler) {
                requestedURL = url
                
                let data = "Hello world".data(using: .utf8)
                completionHandler(data, nil, nil)
            }
        }
        
        let engine = NetworkEngineMock()
        let loader = DataLoader(engine: engine)
        var result: DataLoader.Result?
        let url = URL(string: "my/API")!
        loader.load(from: url) { data in
            result = data
        }
        
        XCTAssertEqual(engine.requestedURL, url)
        XCTAssertNotNil(result)
    }
}
