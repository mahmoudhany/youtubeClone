//
//  ViewController.swift
//  Youtube
//
//  Created by Mahmoud on 4/1/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
   

   let cellId = "cellId"
   let titles = ["Home", "Trending", "Subscriptions", "Account"]

   lazy var settingsLauncher: SettingsLauncher = {
      let launcher = SettingsLauncher()
      launcher.homeController = self
      return launcher
   }()
   lazy var menuBar: MenuBar = {
      let mb = MenuBar()
      mb.homeController = self
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
      
      setupMenuBar()
      setupNavigationBarButtons()
      setupCollectionView()
   }
 
   
   func setupCollectionView(){
      collectionView?.backgroundColor = .white
//      collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
      
      if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
         flowLayout.scrollDirection = .horizontal
      }
      collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
      collectionView?.isPagingEnabled = true
      collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
      collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
   }
   
  
   
   private func setupMenuBar(){
      navigationController?.hidesBarsOnSwipe = true
      let redView = UIView()
      redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
      view.addSubview(redView)
      
      view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
      view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)
      
      view.addSubview(menuBar)
      view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
      view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
      
      menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
   }
   
   func setupNavigationBarButtons(){
      let searchButton = UIBarButtonItem(image: UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
      
      let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
      
      navigationItem.rightBarButtonItems = [moreButton, searchButton]
   }

   func handleMore(){
      settingsLauncher.handleSettings()
   }
   
   func showControllerForSetting(setting: Setting){
      let dummySettingsViewController = UIViewController()
      
      dummySettingsViewController.view.backgroundColor = .white
      dummySettingsViewController.navigationItem.title = setting.name.rawValue
      
      navigationController?.navigationBar.tintColor = .white
      navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
     
      navigationController?.pushViewController(dummySettingsViewController, animated: true)
   }
   
   func handleSearch(){
      print(1)
   }
   internal func setTitleForIndex(index: Int){
      if let titleLabel = navigationItem.titleView as? UILabel{
         titleLabel.text = "  \(self.titles[index])"
      }
   }
   func scrollToMenuIndex(menuIndex: Int){
      let indexPath = IndexPath(item: menuIndex, section: 0)
      collectionView?.scrollToItem(at: indexPath, at: [], animated: false)
      setTitleForIndex(index: menuIndex)
      
   }
}

extension HomeController {
   
   override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return 4
   }
   
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)

      return cell
   }
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: view.frame.width, height: view.frame.height - 50)
   }
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 0
   }
   override func scrollViewDidScroll(_ scrollView: UIScrollView) {
      menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
   }
   
   override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
      
      let index = targetContentOffset.pointee.x / view.frame.width
      let indexPath = IndexPath(item: Int(index), section: 0)
      menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
      setTitleForIndex(index: Int(index))
   }
   
}







