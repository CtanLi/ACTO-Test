//
//  AlbumsCell.swift
//  ACTO-Test
//
//  Created by CtanLI on 2019-11-10.
//  Copyright © 2019 ACTO-Test. All rights reserved.
//

import UIKit

class AlbumsCell: UITableViewCell {

    @IBOutlet weak var albumTitle: UILabel!
    
    var albums: Albums! {
           didSet {
            albumTitle.text = albums.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
