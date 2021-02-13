//
//  LargeHeaderView.swift
//  PhotosAndVideosApp
//
//  Created by  Ananya M on 13/02/21.
//  Copyright © 2021  Ananya M. All rights reserved.
//

import UIKit

class LargeHeaderView: BaseHeaderView {
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet fileprivate weak var headerTitleLabel: UILabel!
    @IBOutlet fileprivate weak var headerSubTitleLabel: UILabel!
    @IBOutlet fileprivate weak var seachView: UIView!
    @IBOutlet weak var seachTextField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView(with frame: CGRect,
         title: String,
         subTitle: String,
         backgroundImage: String) {

        self.frame = frame
        self.headerTitleLabel.text = title
        self.headerSubTitleLabel.text = subTitle
        
        if let url = NSURL(string: backgroundImage) {
            if let data = NSData(contentsOf: url as URL) {
                self.bannerImageView.image = UIImage(data: data as Data)
                self.bannerImageView.contentMode = .scaleToFill
            }
        }
    }
    
    func collapsLargerHeader() {
        self.headerTitleLabel.isHidden = true
        self.headerSubTitleLabel.isHidden = true
        self.seachView.isHidden = true
    }
    
    func expandlargeHeader() {
        self.headerTitleLabel.isHidden = false
        self.headerSubTitleLabel.isHidden = false
        self.seachView.isHidden = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    class func getInstance() -> LargeHeaderView? {
        
        let nib = UINib(nibName: String.getStringOfClass(objectClass: LargeHeaderView.self),
                        bundle: Bundle.main)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? LargeHeaderView
    }
}
