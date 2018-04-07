//
//  VideoCell.swift
//  Youtube
//
//  Created by Mahmoud on 4/2/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import Foundation
import UIKit

class VideoCell: BaseCell{
   
   var video: Video?{
      didSet{
         titleLabel.text = video?.title
         downloadThumbnailImage()
         downloadProfileImage()
         
         if let userProfileImage = video?.channel?.profileImageName{
            userProfileImageView.image = UIImage(named: userProfileImage)
         }
         if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews{
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            
            subTitleTextView.text = "\(channelName) • \(String(describing: numberFormatter.string(from: numberOfViews)!)) • 2 years ago"
         }
         
         if let title = video?.title{
            let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            
            let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
            
            if estimatedRect.size.height > 14{
               titleLabelHeightConstraints?.constant = 44
            }else{
               titleLabelHeightConstraints?.constant = 20
            }
            
         }
      }
   }
   
   let thumbnailImageView: CustomImageView = {
      let imageView = CustomImageView()
      imageView.image = UIImage(named: "taylor Swift")
      imageView.contentMode = .scaleAspectFill
      imageView.clipsToBounds = true
      return imageView
   }()
   
   let seperatorView: UIView = {
      let view = UIView()
      view.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
      return view
   }()
   
   let userProfileImageView: CustomImageView = {
      let imageView = CustomImageView()
      imageView.image = UIImage(named: "taylor_swift_profile")
      imageView.contentMode = .scaleAspectFill
      imageView.layer.cornerRadius = 22
      imageView.layer.masksToBounds = true
      return imageView
   }()
   
   let titleLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.numberOfLines = 2
      label.text = "Taylor Swift - Blank space"
      return label
   }()
   
   let subTitleTextView: UITextView = {
      let textView = UITextView()
      textView.translatesAutoresizingMaskIntoConstraints = false
      textView.isUserInteractionEnabled = false
      textView.text = "TaylorSwiftVEVO • 1,434,546 views • 2 years ago"
      textView.textColor = .lightGray
      textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
      return textView
   }()
   
   var titleLabelHeightConstraints: NSLayoutConstraint?
   
   func downloadThumbnailImage(){
      if let thumbnailImageUrl = video?.thumbnailImageName{
        thumbnailImageView.loadImageFormStringUrl(url: thumbnailImageUrl)
      }
   }
   
   func downloadProfileImage(){
      if let profileImageUrl = video?.channel?.profileImageName{
         userProfileImageView.loadImageFormStringUrl(url: profileImageUrl)
      }
   }
   
   override func setupViews(){
      addSubview(thumbnailImageView)
      addSubview(userProfileImageView)
      addSubview(seperatorView)
      addSubview(titleLabel)
      addSubview(subTitleTextView)
      
      addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
      addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
      
      addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView, userProfileImageView, seperatorView)
      
      addConstraintsWithFormat(format: "H:|[v0]|", views: seperatorView)
      
      //top
      addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
      //left
      addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
      //right
      addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
      // Height
      
      titleLabelHeightConstraints = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
      addConstraint(titleLabelHeightConstraints!)
      
      
      
      //top
      addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
      //left
      addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
      //right
      addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
      // Height
      addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
      
      
   }
   
   
}








