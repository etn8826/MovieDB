//
//  DateHelperTest.swift
//  MovieBrowserTests
//
//  Created by Einstein Nguyen on 11/10/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation
import XCTest
@testable import MovieBrowser

class DateHelperTest: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testconvertDTToString() throws {
        let testDate = "2017-07-17"
        let testMovieDetailDateString = "7/17/17"
        let testSearchResultDateString = "July 17, 2017"
        let wrongFormatDateString = "07-17-2017"
        
        let sutMovieDetailDateString = DateHelper.convertWebFormatDateString(dateString: testDate, to: .movieDetailsDate)
        let sutSearchResultDateString = DateHelper.convertWebFormatDateString(dateString: testDate, to: .searchResultsDate)
        let sutNilDateString = DateHelper.convertWebFormatDateString(dateString: nil, to: .searchResultsDate)
        let sutWrongFormatDateString = DateHelper.convertWebFormatDateString(dateString: wrongFormatDateString, to: .searchResultsDate)
        
        XCTAssertTrue(sutMovieDetailDateString == testMovieDetailDateString)
        XCTAssertTrue(sutSearchResultDateString == testSearchResultDateString)
        XCTAssertTrue(sutNilDateString == "")
        XCTAssertTrue(sutWrongFormatDateString == wrongFormatDateString)
    }
}
