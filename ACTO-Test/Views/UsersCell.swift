//
//  UsersCell.swift
//  ACTO-Test
//
//  Created by CtanLI on 2019-11-10.
//  Copyright © 2019 ACTO-Test. All rights reserved.
//

import UIKit

class UsersCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var address: UILabel!
    
    var users: Users! {
         didSet {
            name.text = users.name
            companyName.text = users.company?.name
            website.text = users.website
            email.text = users.email
            phone.text = users.phone
            if let username = users.username, let street = users.address?.street, let city = users.address?.city, let suite = users.address?.suite {
            userName.text = "@\(username)"
            address.text = "\(street), \(city) \(suite)"
            }
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
