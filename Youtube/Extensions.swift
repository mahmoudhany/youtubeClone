//
//  Extensions.swift
//  Youtube
//
//  Created by Mahmoud on 4/4/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import UIKit

extension UIColor{
   static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
      return UIColor(displayP3Red: red/255, green: green/255, blue: blue/255, alpha: 1)
   }
}


extension UIView{
   
   func addConstraintsWithFormat(format: String, views: UIView...){
      
      var viewsDictionary = [String: UIView]()
      
      for (index, view) in views.enumerated(){
         let key = "v\(index)"
         
         view.translatesAutoresizingMaskIntoConstraints = false
         viewsDictionary[key] = view
      }
      
      addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
   }
}
let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView{
   var imageUrlString: String?
   func loadImageFormStringUrl(url: String){
      imageUrlString = url
      image = nil
      if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage{
         self.image = imageFromCache
         return
      }
      
      let imageUrl = URL(string: url)
      URLSession.shared.dataTask(with: imageUrl!, completionHandler: { (data, response, error) in
         
         if error != nil{
            print(error!)
         }
         
         DispatchQueue.main.async {
            let imageToCache = UIImage(data: data!)
            
            if self.imageUrlString == url{
               self.image = imageToCache
            }
            
            imageCache.setObject(imageToCache!, forKey: url as AnyObject)
            
         }
         
      }).resume()
   }
}








