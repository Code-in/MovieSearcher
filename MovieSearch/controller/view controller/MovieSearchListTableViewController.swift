//
//  MovieSearchListTableViewController.swift
//  MovieSearch
//
//  Created by Pete Parks on 5/1/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import UIKit

class MovieSearchListTableViewController: UITableViewController {

    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieSearchCell else { return UITableViewCell() }

        let movie = movies[indexPath.row]
        print("Cell ===================== Movie: \(movie)")
        cell.movie = movie

        return cell
    }
}


extension MovieSearchListTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
    // Create a switch for the apple store semented controller
        MovieSearchController.fetchMoviesFor(searchTerm: searchTerm) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.movies = movies
                    print(movies)
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.errorDescription ?? "error!")
                }
            }
        }
    } // EoF
} // EoE
