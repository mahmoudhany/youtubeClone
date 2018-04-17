//
//  SettingsLauncher.swift
//  Youtube
//
//  Created by Mahmoud on 4/9/18.
//  Copyright © 2018 Mahmoud. All rights reserved.
//

import UIKit

enum settingName: String {
   case cancel = "Cancel"
   case settings = "settings"
   case termsPrivacy = "Terms & privacy policy"
   case sendFeedback = "Send Feedback"
   case help = "Help"
   case switchAccount = "Switch Account"
}

class SettingsLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
   
   let settingsView = UIView()
   let cellId = "settingsCell"
   let cellHeight: CGFloat = 50
   var homeController: HomeController?
   
   let settings: [Setting] = {
      return [
         Setting(name: .settings , imageName: "settings"),
         Setting(name: .termsPrivacy, imageName: "privacy"),
         Setting(name: .sendFeedback, imageName: "feedback"),
         Setting(name: .help, imageName: "help"),
         Setting(name: .switchAccount, imageName: "switch_account"),
         Setting(name: .cancel, imageName: "cancel")
      ]
   }()
   
   let collectionView: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
      cv.backgroundColor = .white
      return cv
   }()
   
   override init() {
      super.init()
      collectionView.delegate = self
      collectionView.dataSource = self
      collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
   }
   
   func handleSettings(){
      if let window = UIApplication.shared.keyWindow{
         
         settingsView.backgroundColor = UIColor(white: 0, alpha: 0.5)
         settingsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
         
         window.addSubview(settingsView)
         window.addSubview(collectionView)
         
         settingsView.frame = window.frame
         settingsView.alpha = 0
         
         let height: CGFloat = CGFloat(settings.count) * cellHeight
         let y = window.frame.height - height
         
         collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
         
         UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.settingsView.alpha = 1
            self.collectionView.frame = CGRect(x: 0, y: y, width: window.frame.width, height: height)
         })
         
      }
   }
   
   func handleDismiss(setting: Setting){
      
      UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
         if let window = UIApplication.shared.keyWindow{
            let height: CGFloat = CGFloat(self.settings.count) * self.cellHeight
            
            self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
         }
         self.settingsView.alpha = 0
         
      }) { (completed: Bool) in
         
         if setting.name != .cancel{
            self.homeController?.showControllerForSetting(setting: setting)
         }
      }
      
   }
}

extension SettingsLauncher{
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return settings.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
      
      cell.setting = settings[indexPath.item]
      return cell
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: collectionView.frame.width, height: cellHeight)
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 0
   }
   
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
      let setting = self.settings[indexPath.item]
      handleDismiss(setting: setting)
   }
   
}










