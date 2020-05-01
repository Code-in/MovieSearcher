//
//  MovieSearchCell.swift
//  MovieSearch
//
//  Created by Pete Parks on 5/1/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import UIKit

class MovieSearchCell: UITableViewCell {
    
    @IBOutlet weak var movieDescriptionOutlet: UILabel!
    @IBOutlet weak var movieRatingsOutlet: UILabel!
    @IBOutlet weak var movieTitleOutlet: UILabel!
    @IBOutlet weak var movieImageOutelt: UIImageView!
    // MARK: Properties
    var movie: Movie? {
        didSet {
            print("DidSet Movie")
            updateView()
        }
    }

    
    func updateView() {
        print("updateView -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-")
        guard let title = movie?.title else { return }
        movieTitleOutlet.text = title
        guard let rating = movie?.vote_average else { return }
        movieRatingsOutlet.text = "\(rating)"
        guard let description = movie?.overview else { return }
        movieDescriptionOutlet.text = String(description)
        
        guard let posterPath = movie?.poster_path else { return }
        
        MovieSearchController.fetchImageWith(urlString: posterPath) { (result) in
            print("RESULT***********, \(result)")
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.movieImageOutelt.image = image
                case .failure(let error):
                    print(error.errorDescription ?? "error!")
                }
            }
        }
        
    } // EoF


}
