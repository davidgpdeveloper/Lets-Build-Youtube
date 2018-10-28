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
        
        
        URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            
            var videos = [Video]()
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                for dictionary in json as! [[String : AnyObject]] {
                    
                    let video = Video()
                    video.title = dictionary["title"] as! String
                    video.thumnailImageName = dictionary["thumbnail_image_name"] as! String
                    
                    let channelDict = dictionary["channel"] as! [String : AnyObject]
                    
                    let channel = Channel()
                    channel.name = channelDict["name"] as! String
                    channel.profileImageName = channelDict["profile_image_name"] as! String
                    
                    video.channel = channel
                    videos.append(video)
                }
                
                DispatchQueue.main.async {
                    completion(videos)
                    
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
        }).resume()
    }
    
}
