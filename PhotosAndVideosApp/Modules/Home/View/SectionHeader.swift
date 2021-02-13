//
//  SectionHeader.swift
//  PhotosAndVideosApp
//
//  Created by  Ananya M on 13/02/21.
//  Copyright © 2021  Ananya M. All rights reserved.
//

import UIKit
protocol SectionHeaderDelegate {
    func selectedType(type: Types)
}
class SectionHeader: UIView {
    
    @IBOutlet weak var photosIndicatorView: UIView!
    @IBOutlet weak var videosIndicatorView: UIView!
    @IBOutlet weak var favoritesIndicatorView: UIView!
    
    var isType: Types?
    var delegate: SectionHeaderDelegate?
    
    @IBAction func photosButtontapped(_ sender: UIButton) {
        isType = .Photos
        self.photosIndicatorView.isHidden = false
        self.videosIndicatorView.isHidden = true
        self.favoritesIndicatorView.isHidden = true
        delegate?.selectedType(type: isType ?? .Photos)
    }
    @IBAction func videosButtonTapped(_ sender: UIButton) {
        isType = .Videos
        self.photosIndicatorView.isHidden = true
        self.videosIndicatorView.isHidden = false
        self.favoritesIndicatorView.isHidden = true
        delegate?.selectedType(type: isType ?? .Videos)
    }
    
    @IBAction func favoritesButtontapped(_ sender: Any) {
        isType = .favorites
        self.photosIndicatorView.isHidden = true
        self.videosIndicatorView.isHidden = true
        self.favoritesIndicatorView.isHidden = false
        delegate?.selectedType(type: isType ?? .favorites)
    }
    
    class func getInstance() -> SectionHeader? {
          
        let nib = UINib(nibName: String.getStringOfClass(objectClass: SectionHeader.self),
                        bundle: Bundle.main)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? SectionHeader
    }
    
    func configureHeaderView(isType: Types) {
        self.photosIndicatorView.isHidden = !(isType == .Photos)
        self.videosIndicatorView.isHidden = !(isType == .Videos)
        self.favoritesIndicatorView.isHidden = !(isType == .favorites)
    }
}
