//
//  ApiService.swift
//  Youtube
//
//  Created by Mahmoud on 4/16/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import UIKit

class ApiService: NSObject {
   
   static let sharedInstance = ApiService()
   
   func fetchVideos(completion: @escaping ([Video]) -> ()){
      
      let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
      URLSession.shared.dataTask(with: url!) { (data, response, error) in
         if let error = error{
            print(error)
         }
         do {
            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
            var videos = [Video]()
            for dictionary in json as! [Dictionary<String, AnyObject>]{
               
               let video = Video()
               video.title = dictionary["title"] as? String
               video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
               video.numberOfViews = dictionary["number_of_views"] as? NSNumber
               
               let channelDict = dictionary["channel"] as? [String: AnyObject]
               let channel = Channel()
               channel.name = channelDict?["name"] as? String
               channel.profileImageName = channelDict?["profile_image_name"] as? String
               
               video.channel = channel
               videos.append(video)
            }
            DispatchQueue.main.async {
               completion(videos)
            }
            
         }catch let error as NSError{
            print(error)
         }
         
         }.resume()
      
   }
   
}
