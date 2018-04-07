//
//  MenuBar.swift
//  Youtube
//
//  Created by Mahmoud on 4/4/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import UIKit

class MenuBar: UIView{

   lazy var collectionView: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
      cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
      cv.delegate = self
      cv.dataSource = self
      return cv
   }()
   let cellId = "cellId"
   let imageNames = ["home", "trending", "subscriptions", "account"]
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
      
      addSubview(collectionView)
      
      addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
      addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
      
      let selectedIndex = IndexPath(item: 0, section: 0)
      collectionView.selectItem(at: selectedIndex, animated: true, scrollPosition: .centeredVertically)
   }
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
}

extension MenuBar: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
   
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return 4
   }
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
      
      cell.imageView.image = UIImage(named: "\(imageNames[indexPath.item])")?.withRenderingMode(.alwaysTemplate)
      cell.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
      
      return cell
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: frame.width / 4, height: frame.height)
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      return 0
   }
}



