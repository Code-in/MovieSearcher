//
//  MovieSearchController.swift
//  MovieSearch
//
//  Created by Pete Parks on 5/1/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//
import Foundation
import UIKit.UIImage

class MovieSearchController {

    static let baseURL = URL(string: "https://api.themoviedb.org/3")
    static let searchCompenent = "search"
    static let searchCompenent2 = "movie"
    static let enityKey = "api_key"
    static let valueKey = "92dd94abdeb9d745ca36184cf731dc3c"
    static let enityKey2 = "query"
    static let valueKey2 = "Star+Wars"
    
    
    
    static func fetchMoviesFor(searchTerm: String, completion: @escaping
        (Result<[Movie], MovieSearchError>) -> Void) {
        let movieTitle = searchTerm.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL))}
        let url = baseURL.appendingPathComponent(searchCompenent).appendingPathComponent(searchCompenent2)
        var compenents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let entityQuery = URLQueryItem(name: enityKey, value: valueKey)
        let entityQuery2 = URLQueryItem(name: enityKey2, value: movieTitle)
        compenents?.queryItems = [entityQuery, entityQuery2]
        
        
        guard let finalURL = compenents?.url else { return completion(.failure(.invalidURL)) }
        print("Apps finalURL:  \(finalURL.absoluteString)")
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("have an error connecting with server")
                print(error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            print("No data")
            guard let data = data else { return completion(.failure(.invalidURL)) }
            print("Seem to have data")
            do {
                let topLevelObject = try JSONDecoder().decode(MovieTopLevelObject.self, from: data)
                print("Movies: \(topLevelObject)")
                let movies = topLevelObject.results
                print("Movies: \(movies)")
                return completion(.success(movies))
            } catch {
                print(error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            
            
        }.resume()
    }
    
    static func fetchImageWith(urlString: String, completion: @escaping (Result<UIImage, MovieSearchError>) -> Void) {
        guard let baseURL = URL(string: urlString) else { return completion(.failure(.invalidURL))}
        
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            
            // Check the session data
            guard let data = data else { return completion(.failure(.noData)) }
            print(data)
            // load UIImage from data
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            
            // success return image via the completion handler Result success with an image
            print("SUCEESSFULLY LOADED IMAGE")
            return completion(.success(image))
    
        }.resume()
    } // EoF
        
    
    

    
}

