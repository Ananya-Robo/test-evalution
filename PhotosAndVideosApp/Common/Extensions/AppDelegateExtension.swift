//
//  AppDelegateExtension.swift
//  PhotosAndVideosApp
//
//  Created by  Ananya M on 13/02/21.
//  Copyright © 2021  Ananya M. All rights reserved.
//

import UIKit
extension AppDelegate {

    class func getRootVC() -> UIViewController? {

        guard let appdelegate = UIApplication.shared.delegate,
            let rootVC = appdelegate.window??.rootViewController else {
                return nil
        }
        return rootVC
    }

    class func setWindowRoot(vc : UIViewController) {

        let appDelegate = UIApplication.shared.delegate
        if let window = appDelegate?.window {
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        }
    }
}
