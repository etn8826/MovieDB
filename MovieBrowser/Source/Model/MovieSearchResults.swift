//
//  MovieSearchResults.swift
//  MovieBrowser
//
//  Created by Einstein Nguyen on 11/10/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

struct MovieSearchResults: Decodable {
    enum CodingKeys: String, CodingKey {
        case results
    }
    
    var results: [Details]
    
    init(from decoder: Decoder) throws {
        let container     = try decoder.container(keyedBy: CodingKeys.self)
        self.results      = try container.decode([Details].self, forKey: .results)
    }
}

