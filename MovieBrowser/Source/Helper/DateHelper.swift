//
//  DateHelper.swift
//  MovieBrowser
//
//  Created by Einstein Nguyen on 11/10/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

struct DateHelper {
    
    // Helper class to convert the API release date into multiple formats
    enum DateFormat: String {
        case searchResultsDate = "MMMM dd, yyyy"
        case movieDetailsDate = "M/dd/yy"
    }
    
    static func convertWebFormatDateString(dateString: String?, to format: DateFormat) -> String {
        guard let dateString = dateString else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = format.rawValue
            return dateFormatter.string(from: date)
        }
        return dateString
    }
}
