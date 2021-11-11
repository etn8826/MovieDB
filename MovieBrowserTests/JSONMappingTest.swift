//
//  JSONMappingTest.swift
//  MovieBrowserTests
//
//  Created by Einstein Nguyen on 11/10/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation
import XCTest
@testable import MovieBrowser

class JSONMappingTest: XCTestCase {
    
    func testJSONMapping() throws {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "mock_json", withExtension: "json") else {
            XCTFail("Missing file: User.json")
            return
        }
        
        let data = try Data(contentsOf: url)
        let searchResults: MovieSearchResults = try JSONDecoder().decode(MovieSearchResults.self, from: data)
        
        let title = "Fast & Furious 10"
        let overview = "The tenth installment in the Fast Saga."
        let voteAverage = 0.0
        let posterPath = "/2DyEk84XnbJEdPlGF43crxfdtHH.jpg"
        let releaseDate = "2023-04-06"
        XCTAssertNotNil(searchResults.results)
        XCTAssertEqual(searchResults.results[0].voteAverage, voteAverage)
        XCTAssertEqual(searchResults.results[0].releaseDate, releaseDate)
        XCTAssertEqual(searchResults.results[0].posterPath, posterPath)
        XCTAssertEqual(searchResults.results[0].overview, overview)
        XCTAssertEqual(searchResults.results[0].originalTitle, title)
    }
}
