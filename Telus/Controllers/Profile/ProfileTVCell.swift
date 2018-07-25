//
//  ProfileTVCell.swift
//  Telus
//
//  Created by Mudassir Abbas on 22/07/2018.
//  Copyright © 2018 Mudassir Abbas. All rights reserved.
//

import UIKit

class ProfileTVCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var progressView: WAView!
    @IBOutlet weak var profileBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
