//
//  StringExtension.swift
//  PhotosAndVideosApp
//
//  Created by  Ananya M on 13/02/21.
//  Copyright © 2021  Ananya M. All rights reserved.
//

import Foundation

extension String{
    /// This method returns Class name as String
    ///
    /// - Parameter objectClass: AnyClass
    /// - Returns: String
    static func getStringOfClass(objectClass: AnyClass) -> String {
        let className = String(describing: objectClass.self)
        return className
    }
}
