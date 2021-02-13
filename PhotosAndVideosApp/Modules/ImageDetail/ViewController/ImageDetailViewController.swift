//
//  ImageDetailViewController.swift
//  PhotosAndVideosApp
//
//  Created by  Ananya M on 13/02/21.
//  Copyright © 2021  Ananya M. All rights reserved.
//


import UIKit

class ImageDetailViewController: BaseViewController {
    //MARK: Outlets
    
    //MARK: Properties
    lazy var activityIndicator = ActivityIndicatorView()

    //MARK: life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK: storyboard init helper
    class var instance: ImageDetailViewController {
        return Storyboard.imageDetail.instantiateVC(ImageDetailViewController.self)
    }
}
