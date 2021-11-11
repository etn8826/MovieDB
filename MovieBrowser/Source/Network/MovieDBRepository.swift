//
//  MovieDBRepository.swift
//  MovieBrowser
//
//  Created by Einstein Nguyen on 11/10/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

struct MovieDBRepository {
    static func getMovieDetails(movie: String, success: @escaping (MovieSearchResults) -> Void, failure: @escaping (Error) -> Void) {
        // Setting the url here since this is the only request made
        let queryString = movie.replacingOccurrences(of: " ", with: "+")
        let apiKey = "5885c445eab51c7004916b9c0313e2d3"
        let path = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=en-US&query=\(queryString)&page=1&include_adult=false"
        
        guard let url = URL(string: path) else {
            let error = NSError(domain: "", code: 0, userInfo: [ NSLocalizedDescriptionKey: "Error generating path"])
            failure(error)
            return
        }
        
        let getSuccess: (Data) -> Void = { data in
            do {
                let movieSearch = try JSONDecoder().decode(MovieSearchResults.self, from: data)
                success(movieSearch)
            } catch let error {
                failure(error)
            }
        }
        
        DataLoader().load(from: url) { result in
            switch result {
            case .data(let data):
                getSuccess(data)
            case .error(let error):
                failure(error)
            }
        }
    }
}

