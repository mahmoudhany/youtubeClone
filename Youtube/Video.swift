//
//  Video.swift
//  Youtube
//
//  Created by Mahmoud on 4/7/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import UIKit

class Video: NSObject{
   
   var thumbnailImageName: String?
   var title: String?
   var channel: Channel?
   var numberOfViews: NSNumber?
   var uploadDate: NSDate?
}


class Channel: NSObject {
   var name: String?
   var profileImageName: String?
}
