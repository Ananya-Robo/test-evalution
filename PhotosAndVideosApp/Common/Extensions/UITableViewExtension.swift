//
//  UITableViewExtension.swift
//  PhotosAndVideosApp
//
//  Created by  Ananya M on 13/02/21.
//  Copyright © 2021  Ananya M. All rights reserved.
//

import UIKit

extension UITableView {

    func dequeueReusableCell<T: UITableViewCell>(_ className: T.Type, indexPath: IndexPath) -> T {
        let className = String.getStringOfClass(objectClass: className)
        return self.dequeueReusableCell(withIdentifier: className, for: indexPath) as! T
    }

    func registerNib(_ className: AnyClass) {
        let classNameString = String.getStringOfClass(objectClass: className)
        register(UINib.init(nibName: classNameString, bundle: .main), forCellReuseIdentifier: classNameString)
    }

    func registerClass(_ className: AnyClass) {
        let classNameString = String.getStringOfClass(objectClass: className)
        register(className, forCellReuseIdentifier: classNameString)
    }
}
