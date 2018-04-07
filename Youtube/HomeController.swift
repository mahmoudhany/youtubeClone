//
//  ViewController.swift
//  Youtube
//
//  Created by Mahmoud on 4/1/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
   
   //   var videos: [Video] = {
   //
   //      var channel = Channel()
   //      channel.name = "TaylorSwiftVevo"
   //      channel.profileImageName = "taylor_swift_profile"
   //
   //      var blankSpaceVideo = Video()
   //      blankSpaceVideo.title = "Taylor Swift - Blank Space"
   //      blankSpaceVideo.thumbnailImageName = "taylor Swift"
   //      blankSpaceVideo.channel = channel
   //      blankSpaceVideo.numberOfViews = 14345445216
   //
   //      var badBloodVideo = Video()
   //      badBloodVideo.title = "Taylor Swift - Bad Blood featuring Kendrick Lamar"
   //      badBloodVideo.thumbnailImageName = "taylor_swift_profile"
   //      badBloodVideo.channel = channel
   //      badBloodVideo.numberOfViews = 14345445216
   //
   //      return [blankSpaceVideo, badBloodVideo]
   //   }()
   
   var videos: [Video]?
   
   let menuBar: MenuBar = {
      let mb = MenuBar()
      return mb
   }()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      navigationItem.title = "Home"
      navigationController?.navigationBar.isTranslucent = false
      
      let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
      titleLabel.text = "Home"
      titleLabel.textColor = .white
      titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
      
      navigationItem.titleView = titleLabel
      
      collectionView?.backgroundColor = .white
      collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
      collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
      collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
      
      setupMenuBar()
      setupNavigationBarButtons()
      fetchVideos()
   }
   
   
   func fetchVideos(){
      let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
      URLSession.shared.dataTask(with: url!) { (data, response, error) in
         if let error = error{
            print(error)
         }
         do {
            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
            self.videos = [Video]()
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
               self.videos?.append(video)
            }
            DispatchQueue.main.async {
               self.collectionView?.reloadData()
            }
            
            
         }catch let error as NSError{
            print(error)
         }
         }.resume()
      
      
   }
   
   private func setupMenuBar(){
      view.addSubview(menuBar)
      view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
      view.addConstraintsWithFormat(format: "V:|[v0(50)]|", views: menuBar)
   }
   
   func setupNavigationBarButtons(){
      let searchButton = UIBarButtonItem(image: UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
      
      let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
      
      navigationItem.rightBarButtonItems = [moreButton, searchButton]
   }
   
   func handleSearch(){
      print(1)
   }
   
   func handleMore(){
      print(2)
   }
   
}

extension HomeController {
   
   override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return videos?.count ?? 0
   }
   
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
      cell.video = videos?[indexPath.item]
      return cell
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let height = (view.frame.width - 16 - 16) * 9 / 16
      return CGSize(width: view.frame.width, height: height + 16 + 88)
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 0
   }
   
}







