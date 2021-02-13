//
//  PhotoListTableViewCell.swift
//  PhotosAndVideosApp
//
//  Created by  Ananya M on 13/02/21.
//  Copyright © 2021  Ananya M. All rights reserved.
//

import UIKit

class PhotoListTableViewCell: UITableViewCell {

    @IBOutlet weak var HomeScreenImage: UIImageView!
    @IBOutlet weak var photographerProfileImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var photographerName: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        photographerProfileImage.layer.cornerRadius = photographerProfileImage.frame.width / 2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureHomeScreenCell(imageDetail: Photo) {
        self.playButton.isHidden = true
        if let url = NSURL(string: imageDetail.src.small) {
            if let data = NSData(contentsOf: url as URL) {
                self.HomeScreenImage.image = UIImage(data: data as Data)
                self.HomeScreenImage.contentMode = .scaleToFill
            }
        }
        
        self.photographerName.text = imageDetail.photographer
        if imageDetail.liked {
            self.favoriteButton.setTitle("favouriteButtonUnpressed", for: .normal)
        }else {
            self.favoriteButton.setTitle("favouriteButtonPressed", for: .normal)
        }
    }
    
    func configureHomeVideoCell(videoDetail: Video) {
        self.playButton.isHidden = false
        if let url = NSURL(string: videoDetail.image) {
            if let data = NSData(contentsOf: url as URL) {
                self.HomeScreenImage.image = UIImage(data: data as Data)
                self.HomeScreenImage.contentMode = .scaleToFill
            }
        }
        self.photographerName.text = videoDetail.user.name
        self.favoriteButton.setTitle("favouriteButtonUnpressed", for: .normal)
    }
    
    @IBAction func favoriteButtontapped(_ sender: UIButton) {
    }
}
