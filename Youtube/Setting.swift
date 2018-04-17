//
//  Setting.swift
//  Youtube
//
//  Created by Mahmoud on 4/9/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import Foundation

class Setting: NSObject {
   let name: settingName
   let imageName: String
   
   init(name: settingName, imageName: String) {
      self.name = name
      self.imageName = imageName
   }
   
}
