//
//  TabBarViewController.swift
//  Telus
//
//  Created by Mudassir Abbas on 22/07/2018.
//  Copyright © 2018 Mudassir Abbas. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

let screenWidth = UIScreen.main.nativeBounds.width
class TabBarViewController: UITabBarController,UITabBarControllerDelegate,UINavigationControllerDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "6/29/2018"
        let btn = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(self.showHideMenu(_:)))
        self.tabBarController?.navigationItem.leftBarButtonItem = btn
        // Do any additional setup after loading the view.
    }
    @objc func showHideMenu(_ sender: UIBarButtonItem)
    {
        self.slideMenuController()?.toggleLeft()
    }

    init() {
        // perform some initialization here
        super.init(nibName: nil, bundle: nil)
        //================
        let home = UIStoryboard.storyBoard(withName: .Main).loadViewController(withIdentifier: .dashboardVC)
        home.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home"), selectedImage: #imageLiteral(resourceName: "home"))
        home.tabBarItem.tag = 0
        let homeNav = UINavigationController(rootViewController: home)
        //================
        let profile = UIStoryboard.storyBoard(withName: .Main).loadViewController(withIdentifier: .profileVC)
        profile.tabBarItem = UITabBarItem(title: "Profile", image: #imageLiteral(resourceName: "user"), selectedImage: #imageLiteral(resourceName: "user"))
        profile.tabBarItem.tag = 1
        let profileNav = UINavigationController(rootViewController: profile)
        //================
        let security = UIStoryboard.storyBoard(withName: .Main).loadViewController(withIdentifier: .dashboardVC)
        security.tabBarItem = UITabBarItem(title: "Security", image: #imageLiteral(resourceName: "locked-padlock"), selectedImage: #imageLiteral(resourceName: "locked-padlock"))
        security.tabBarItem.tag = 3
        let securityNav = UINavigationController(rootViewController: security)
        //=================
        let diagnose = UIStoryboard.storyBoard(withName: .Main).loadViewController(withIdentifier: .dashboardVC)
        diagnose.tabBarItem = UITabBarItem(title: "Diagnose", image: #imageLiteral(resourceName: "check"), selectedImage: #imageLiteral(resourceName: "check"))
        diagnose.tabBarItem.tag = 2
        let diagnoseNav = UINavigationController(rootViewController: diagnose)
        //=================
        let settings = UIStoryboard.storyBoard(withName: .Main).loadViewController(withIdentifier: .dashboardVC)
        settings.tabBarItem = UITabBarItem(title: "Settings", image: #imageLiteral(resourceName: "controls"), selectedImage: #imageLiteral(resourceName: "controls"))
        settings.tabBarItem.tag = 4
        let settingsNav = UINavigationController(rootViewController: settings)
        self.tabBar.tintColor = UIColor(hexString: navbarClr)
        viewControllers = [homeNav,profileNav,securityNav,diagnoseNav,settingsNav]
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if screenWidth == 2048 {
            self.tabBar.itemSpacing = CGFloat(UITabBarItemPositioning.automatic.rawValue)
            self.tabBarItem.imageInsets =  UIEdgeInsetsMake(15, 0, -15, 0)
            self.tabBarItem.title = nil
            self.tabBar.itemSpacing = UIScreen.main.bounds.width / 8
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController){
        _ = viewController.tabBarItem.tag
    }
    
    private func findSelectedTagForTabBarController(tabBarController: UITabBarController?) {
        
        if let tabBarController = tabBarController {
            if let viewControllers = tabBarController.viewControllers {
                let selectedIndex = tabBarController.selectedIndex
                let selectedController: UIViewController? = viewControllers.count > selectedIndex ? viewControllers[selectedIndex] : nil
                if let tag = selectedController?.tabBarItem.tag {
                    //here you can use your tag
                    print(tag)
                }
            }
        }
    }
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        //findSelectedTagForTabBarController(navigationController.tabBarController)
        print("print \(viewController)")
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
