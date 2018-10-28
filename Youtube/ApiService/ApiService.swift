//
//  ApiService.swift
//  Youtube
//
//  Created by Studiogenesis Home on 22/10/2018.
//  Copyright © 2018 Studiogenesis Home. All rights reserved.
//

import UIKit

class ApiService: NSObject {

    static let sharedInstance = ApiService()
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fechVideos(completion: @escaping ([Video]) -> ()) {
        
        fetchFeedForUrlString(urlString: "\(baseUrl)/home.json", completion: completion)
    }
    
    func fechTrendingFeed(completion: @escaping ([Video]) -> ()) {

        fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json", completion: completion)
    }
    
    func fechSubscriptionFedd(completion: @escaping ([Video]) -> ()) {
  
        fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json", completion: completion)
    }
    

    func fetchFeedForUrlString(urlString: String, completion: @escaping ([Video]) -> ()) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print(error ?? "")
                return
            }
            
            do {
                guard let data = data else { return }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let videos = try decoder.decode([Video].self, from: data)
               
                DispatchQueue.main.async {                    
                    completion(videos)
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            
            
            }.resume()
    }
    
    
    
}
