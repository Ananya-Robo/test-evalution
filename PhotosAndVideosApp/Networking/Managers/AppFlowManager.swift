//
//  AppFlowManager.swift
//  PhotosAndVideosApp
//
//  Created by  Ananya M on 13/02/21.
//  Copyright © 2021  Ananya M. All rights reserved.
//

import UIKit

class AppFlowManager {
    
    // MARK: - Shared Instance
    static let shared = AppFlowManager()
    
    // MARK: - Init method
    private init() {
    }
    //MARK: - Home
      func loadHomeScreen()
      {
          let homeScreenViewController = HomeScreenViewController.instance
         let navigationController = UINavigationController(rootViewController: homeScreenViewController)
          AppDelegate.setWindowRoot(vc: navigationController)
      }
    

    //MARK: - Image Deatil
      func loadImageDetailScreen(on viewController: UIViewController) {
          let vc = ImageDetailViewController.instance
          viewController.navigationController?.pushViewController(vc, animated: true)
      }
}
