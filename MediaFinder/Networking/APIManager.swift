//
//  APIManager.swift
//  MediaFinder
//
//  Created by Khaled L Said on 3/30/20.
//  Copyright © 2020 Intake4. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    static func loadMovies(completion: @escaping (_ error: Error?, _ movies: [MoviesData]?) -> Void) {
        AF.request(Urls.base, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: nil).response { response in
            
            guard  response.error == nil else {
                print(response.error!)
                completion(response.error, nil)
                return
            }
            guard let data = response.data else {
                print("Could not get any data")
                return
            }
            do {
                let decoder = JSONDecoder()
                let moviesArr = try decoder.decode([MoviesData].self, from: data)
                completion(nil, moviesArr)
            } catch let error {
                print(error)
            }
        
        }
    }
}
