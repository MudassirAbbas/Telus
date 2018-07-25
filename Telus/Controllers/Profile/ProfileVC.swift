//
//  ProfileVC.swift
//  Telus
//
//  Created by Mudassir Abbas on 22/07/2018.
//  Copyright © 2018 Mudassir Abbas. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var name = ["Johne","Aline","Jane","Andrew"]
    var img = [#imageLiteral(resourceName: "rob-sperry-round-profile"),#imageLiteral(resourceName: "profile-pic-round-200px"),#imageLiteral(resourceName: "profile_round"),#imageLiteral(resourceName: "Unknown")]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "John WiFi"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->  UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "ProfileTblCell", for: indexPath) as! ProfileTVCell
        cell.title.text = name[indexPath.row]
        cell.profileBtn.setImage(img[indexPath.row], for: .normal)
        if indexPath.row == 1 || indexPath.row == 3{
        cell.progressView.backgroundColor = UIColor.red
        }else if indexPath.row == 2{
            cell.progressView.backgroundColor = UIColor.blue
        }
       return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.storyBoard(withName: .Main).loadViewController(withIdentifier: .profileDetailVC)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
