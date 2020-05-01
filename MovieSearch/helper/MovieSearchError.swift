//
//  MovieSearchError.swift
//  MovieSearch
//
//  Created by Pete Parks on 5/1/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import Foundation

enum MovieSearchError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach the server"
        case .thrownError(let error):
            return error.localizedDescription
        case .noData:
            return "The server responded with no data"
        case .unableToDecode:
            return "There server responded with bad data"
        }
    }
}
