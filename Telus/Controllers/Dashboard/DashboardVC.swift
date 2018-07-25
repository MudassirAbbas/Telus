//
//  DashboardVC.swift
//  Construction
//
//  Created by Mudassir Abbas on 30/06/2018.
//  Copyright © 2018 Mudassir Abbas. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var clView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "6/29/2018"
        let btn = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(self.showHideMenu(_:)))
        self.navigationItem.leftBarButtonItem = btn
        clView.delegate = self
        clView.dataSource = self
        clView.reloadData()
        self.clView.scrollToItem(at: IndexPath(item: 1,section: 0), at: .right, animated: true)
        // Do any additional setup after loading the view.
    }
    @objc func showHideMenu(_ sender: UIBarButtonItem)
    {
        self.slideMenuController()?.toggleLeft()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardCell", for: indexPath) as! DashboardCell
        cell.backView.dropShadow(color: .red, opacity: 1, offSet: CGSize(width: 1, height: 1), radius: 3, scale: true)
        return cell
    }
    // OUTPUT 2
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
extension UIView {
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor(hexString: navbarClr).cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        self.backgroundColor = UIColor.white
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
