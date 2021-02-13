//
//  ActivityIndicatorView.swift
//  PhotosAndVideosApp
//
//  Created by  Ananya M on 13/02/21.
//  Copyright © 2021  Ananya M. All rights reserved.
//

import UIKit

class ActivityIndicatorView: UIActivityIndicatorView {

    func showActivityIndicator(view: UIView) {
        showActivityIndicator(view: view, color: .black, style: UIActivityIndicatorView.Style.gray, enableUserInteraction: false)
    }
    
    func showActivityIndicator(view: UIView, enableUserInteraction: Bool) {
        showActivityIndicator(view: view, color: .black, style: UIActivityIndicatorView.Style.gray, enableUserInteraction: enableUserInteraction)
    }
    
    func showActivityIndicator(view: UIView, color: UIColor, style: UIActivityIndicatorView.Style, enableUserInteraction: Bool) {
        
        frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        center = view.center
        hidesWhenStopped = true
        self.style = style
        view.addSubview(self)
        view.bringSubviewToFront(self)
        translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        view.addConstraint(horizontalConstraint)
        
        let verticalConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        view.addConstraint(verticalConstraint)
        self.color = color
        startAnimating()
        view.isUserInteractionEnabled = enableUserInteraction
    }
    
    func removeActivityIndicator() {
        superview?.isUserInteractionEnabled = true
        stopAnimating()
        removeFromSuperview()
    }
}
