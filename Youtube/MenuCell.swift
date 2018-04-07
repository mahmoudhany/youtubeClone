//
//  MenuCell.swift
//  Youtube
//
//  Created by Mahmoud on 4/5/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import UIKit

class MenuCell: BaseCell{
   
   
   let imageView: UIImageView = {
      let iv = UIImageView()
      iv.image = UIImage(named: "home")
      return iv
   }()
   
   override func setupViews() {
      super.setupViews()
      addSubview(imageView)
      
      addConstraintsWithFormat(format: "H:[v0(28)]", views: imageView)
      addConstraintsWithFormat(format: "V:[v0(28)]", views: imageView)
      
      addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
      addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
      
   }
   override var isSelected: Bool{
      didSet{
         imageView.tintColor = isSelected ? .white : UIColor.rgb(red: 91, green: 14, blue: 13)
      }
   }
   
}
