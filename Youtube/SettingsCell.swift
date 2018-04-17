//
//  SettingsCell.swift
//  Youtube
//
//  Created by Mahmoud on 4/9/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
   override var isHighlighted: Bool{
      didSet{
         backgroundColor = isHighlighted ? .darkGray : .white
         nameLabel.textColor = isHighlighted ? .white : .black
         iconImageView.tintColor = isHighlighted ? .white : .darkGray
      }
   }
   
   var setting: Setting?{
      didSet{
         nameLabel.text = setting?.name.rawValue
         if let imageName = setting?.imageName{
            iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
            iconImageView.tintColor = .darkGray
         }
      }
   }
   
   let iconImageView: UIImageView = {
      let iv = UIImageView()
      iv.image = UIImage(named: "settings")
      iv.contentMode = .scaleAspectFill
      return iv
   }()
   
   let nameLabel: UILabel = {
      let label = UILabel()
      label.font = UIFont.systemFont(ofSize: 13)
      label.text = "label"
      return label
   }()
   
   override func setupViews() {
      super.setupViews()
      addSubview(nameLabel)
      addSubview(iconImageView)
      
      addConstraintsWithFormat(format: "H:|-16-[v0(30)]-16-[v1]|", views: iconImageView, nameLabel)
      addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
      addConstraintsWithFormat(format: "V:[v0(30)]", views: iconImageView)
      
      addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .centerY, relatedBy: .equal, toItem: iconImageView, attribute: .centerY, multiplier: 1, constant: 0))
   }
   
}
