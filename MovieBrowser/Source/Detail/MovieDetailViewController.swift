//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieOverviewTextView: UITextView!
    var movieDetails: Details?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    private func configureView() {
        guard let details = movieDetails else { return }
        self.movieTitleLabel.text = details.originalTitle
        self.releaseDateLabel.text = "Release Date: \(DateHelper.convertWebFormatDateString(dateString: details.releaseDate, to: .movieDetailsDate))"
        self.movieOverviewTextView.text = details.overview
        self.loadMoviePoster(path: details.posterPath)
    }
    
    private func loadMoviePoster(path: String?) {
        guard let posterPath = path else { return }
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
        guard let url = url else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.moviePoster.image = image
                    }
                }
            }
        }
    }
}
