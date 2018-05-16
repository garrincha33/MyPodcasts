//
//  APIService.swift
//  MyPodcasts
//
//  Created by Richard Price on 16/05/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    
    static let shared = APIService()
    
    func fetchPodcasts(searchText: String, completionHandler: @escaping ([Podcasts]) -> ()) {
        
        let url = "https://itunes.apple.com/search"
        let parameters = ["term": searchText]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).response { (dataResponse) in
            if let err = dataResponse.error {
                print("unable to contact host", err)
                return
            }
            guard let data = dataResponse.data else {return}
            do {
                let searchResult = try
                    JSONDecoder().decode(SearchResults.self, from: data)
                completionHandler(searchResult.results)
            } catch let error {
                print("unable to decode", error)
            }
        }
    }
    
    struct SearchResults: Decodable {
        let resultCount: Int
        let results: [Podcasts]
    }
}
