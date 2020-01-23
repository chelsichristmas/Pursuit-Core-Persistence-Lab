//
//  PhotosAPIClient.swift
//  Persistence-Lab
//
//  Created by Chelsi Christmas on 1/22/20.
//  Copyright © 2020 Chelsi Christmas. All rights reserved.
//

import Foundation

struct PhotosAPIClient {
    static func fetchPhoto(for searchQuery: String,
                            completion: @escaping (Result<[PhotoInfo], AppError>) -> ()) {
      
      let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "flower"
      
      // using string interpolation to build endpoint url
      let photoEndpointURL = "https://pixabay.com/api/?key=15003239-b376045a59a74ecfff7bb35cd&q=\(searchQuery)"
      
      // Later we will look at URLComponents and URLQueryItems
      
      guard let url = URL(string: photoEndpointURL) else {
        completion(.failure(.badURL(photoEndpointURL)))
        return
      }
      
      let request = URLRequest(url: url)
          
      NetworkHelper.shared.performDataTask(with: request) { (result) in
        switch result {
        case .failure(let appError):
          completion(.failure(.networkClientError(appError)))
        case .success(let data):
          do {
            let searchResults = try JSONDecoder().decode(Photo.self, from: data)
            
            // 1. use searchResults to create an array of recipes
            let photos = searchResults.hits
            
            // 2. capture the array of recipes in the completion handler
            completion(.success(photos))
            
          } catch {
            completion(.failure(.decodingError(error)))
          }
        }
      }
      
      
    }
    
    
}
