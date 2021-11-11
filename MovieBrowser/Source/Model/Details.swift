//
//  Details.swift
//  MovieBrowser
//
//  Created by Einstein Nguyen on 11/10/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

struct Details: Decodable {
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case originalTitle = "original_title"
        case voteAverage = "vote_average"
    }
    
    var posterPath: String?
    var overview: String?
    var releaseDate: String?
    var originalTitle: String?
    var voteAverage: Double?
    
    init(from decoder: Decoder) throws {
        let container      = try decoder.container(keyedBy: CodingKeys.self)
        self.posterPath    = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.overview      = try container.decodeIfPresent(String.self, forKey: .overview)
        self.releaseDate   = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        self.originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)
        self.voteAverage   = try container.decodeIfPresent(Double.self, forKey: .voteAverage)
    }
}
