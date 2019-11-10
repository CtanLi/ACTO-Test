//
//  PhotosCell.swift
//  ACTO-Test
//
//  Created by CtanLI on 2019-11-10.
//  Copyright © 2019 ACTO-Test. All rights reserved.
//

import UIKit

class PhotosCell: UITableViewCell {

    @IBOutlet weak var mainUrl: UIImageView!
    @IBOutlet weak var thumbnailUrl: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    var photos: Photos! {
        didSet {
            if let url = photos.url, let thumbnail = photos.thumbnailUrl {
                mainUrl.loadImageUsingCacheWithURLString(urlString: url)
                thumbnailUrl.loadImageUsingCacheWithURLString(urlString: thumbnail)
            }
                title.text = photos.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
