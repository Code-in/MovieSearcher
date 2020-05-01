//
//  Movie.swift
//  MovieSearch
//
//  Created by Pete Parks on 5/1/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import Foundation

struct MovieTopLevelObject: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let title: String
    let vote_average: Float?
    let poster_path: String?
    let overview: String?
}
