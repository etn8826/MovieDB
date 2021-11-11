//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var movieDetailsList: [Details] = []
    let movieDetails = "movieDetails"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCells()
    }
    
    private func registerTableViewCells() {
        let searchCellNib = UINib(nibName: "SearchCell", bundle: nil)
        self.tableView.register(searchCellNib, forCellReuseIdentifier: "searchCell")
    }
    
    // Perform a search on the current seachBar text when "Go" button is pressed
    @IBAction func goPressed(_ sender: Any) {
        guard let searchText = self.searchBar.text else { return }
        self.getResultsFor(searchString: searchText)
    }
    
    // Prepare the Movie detials screen by injecting the details objects
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToMovieDetails" {
            let movieDetailViewController = segue.destination as? MovieDetailViewController
            let obj = sender as? [String: Any?]
            movieDetailViewController?.movieDetails = obj?[movieDetails] as? Details
        }
    }
    
    // Make the API call for the movie string and update the tableview
    private func getResultsFor(searchString: String) {
        self.activityIndicator.startAnimating()
        MovieDBRepository.getMovieDetails(
            movie: searchString,
            success: { [weak self] searchResults in
                DispatchQueue.main.async {
                    self?.movieDetailsList = searchResults.results
                    self?.activityIndicator.stopAnimating()
                    self?.tableView.reloadData()
                }
            },
            failure: { [weak self] error in
                self?.displayErrorAlert(errorMessage: error.localizedDescription)
            }
        )
    }
    
    private func displayErrorAlert(errorMessage: String) {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            let alertAction = UIAlertAction(
                title: "Ok",
                style: .default,
                handler: { [weak self] _ in
                    self?.dismiss(animated: true, completion: nil)
                }
            )
            alert.addAction(alertAction)
            self?.present(alert, animated: true)
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    // Get movie results on each char change on the searchBar
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let searchText = searchBar.text else { return true }
        let searchString = text.isEmpty ? String(searchText.dropLast()) : searchText + text
        self.getResultsFor(searchString: searchString)
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.movieDetailsList.removeAll()
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let isIndexValid = self.movieDetailsList.indices.contains(indexPath.row)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? SearchCell,
              isIndexValid
        else { return UITableViewCell() }
        
        let movieDetails = self.movieDetailsList[indexPath.row]
        cell.movieTitleLabel.text = movieDetails.originalTitle
        cell.releaseDateLabel.text = DateHelper.convertWebFormatDateString(dateString: movieDetails.releaseDate, to: .searchResultsDate)
        if let voteAverageString = movieDetails.voteAverage {
            cell.voteAverageLabel.text = String(voteAverageString)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieDetailsList.count
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
        let userInfo = [movieDetails: self.movieDetailsList[indexPath.row]]
        performSegue(withIdentifier: "segueToMovieDetails", sender: userInfo)
    }
}
