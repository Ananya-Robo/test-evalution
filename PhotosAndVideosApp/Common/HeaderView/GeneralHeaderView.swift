//
//  GeneralHeaderView.swift
//  PhotosAndVideosApp
//
//  Created by  Ananya M on 13/02/21.
//  Copyright © 2021  Ananya M. All rights reserved.
//

import UIKit

class GeneralHeaderView: BaseHeaderView {

    @IBOutlet weak var statusBarHeight: NSLayoutConstraint!
    @IBOutlet weak var topConstraintToImageView: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setUpView() {
        super.setUpView()
    }
    
    class func getInstance() -> GeneralHeaderView? {
        
        let nib = UINib(nibName: String.getStringOfClass(objectClass: GeneralHeaderView.self),
                        bundle: Bundle.main)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? GeneralHeaderView
    }
}

