//
//  UIStoryBoardExtension.swift
//  PhotosAndVideosApp
//
//  Created by  Ananya M on 13/02/21.
//  Copyright © 2021  Ananya M. All rights reserved.
//

import UIKit

enum Storyboard: String {
  
    case home = "Home"
    case imageDetail = "ImageDetail"
   
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func instantiateVC<T: UIViewController>(_ objectClass: T.Type) -> T {
        return instance.instantiateViewController(withIdentifier: String.getStringOfClass(objectClass: objectClass)) as! T
    }
}
