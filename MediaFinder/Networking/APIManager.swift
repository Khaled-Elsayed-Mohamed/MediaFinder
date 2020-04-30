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
    
    
    
    static func loadMovies(search: String, completion: @escaping (_ error: Error?, _ movies: [resultsData]?) -> Void) {
        AF.request(Urls.base, method: HTTPMethod.get, parameters: [parameters.term: search, parameters.media: parameters.scope], encoding: URLEncoding.default, headers: nil).response { response in
            
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
                let resultsArr = try decoder.decode(results.self, from: data).results
                completion(nil, resultsArr)
                print(resultsArr)
            } catch let error {
                print(error)
            }
        
        }
    }
}
