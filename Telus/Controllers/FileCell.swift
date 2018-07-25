//
//  FileCell.swift
//  Construction
//
//  Created by Mudassir Abbas on 30/06/2018.
//  Copyright © 2018 Mudassir Abbas. All rights reserved.
//

import UIKit

class FileCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var measured: UILabel!
    @IBOutlet weak var back_date: UILabel!
    @IBOutlet weak var downloadBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
