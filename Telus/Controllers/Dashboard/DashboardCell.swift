//
//  DashboardCell.swift
//  Telus
//
//  Created by Mudassir Abbas on 22/07/2018.
//  Copyright © 2018 Mudassir Abbas. All rights reserved.
//

import UIKit

class DashboardCell: UICollectionViewCell,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    func SetCell()
    {
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTVCell", for: indexPath) as! ProfileTVCell
        switch indexPath.row {
        case 0:
            cell.icon.image = #imageLiteral(resourceName: "youtube")
            break
        case 1:
            cell.icon.image = #imageLiteral(resourceName: "facebook")
            cell.title.text = "Facebook"
            break
        case 2:
            cell.icon.image = #imageLiteral(resourceName: "instagram")
            cell.title.text = "Instagram"
        case 3:
            cell.icon.image = #imageLiteral(resourceName: "spotify")
            cell.title.text = "Spotify"
            break
        default:
            cell.icon.image = #imageLiteral(resourceName: "facebook")
        }
        return cell
    }
    
}
