//
//  SignUpVC.swift
//  Construction
//
//  Created by Mudassir Abbas on 30/06/2018.
//  Copyright © 2018 Mudassir Abbas. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var company: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SignUpClick(_ sender: UIButton)
    {
        self.view.endEditing(true)
        if name?.text?.count == 0{
            Utilities.showAlertWithTitle(title: "Missing", withMessage: "Name is required", withNavigation: self)
            return
        }
        if emailTxt?.text?.count == 0{
            Utilities.showAlertWithTitle(title: "Missing", withMessage: "Email is required", withNavigation: self)
            return
        }
        if number?.text?.count == 0{
            Utilities.showAlertWithTitle(title: "Missing", withMessage: "Number is required", withNavigation: self)
            return
        }
        if password?.text?.count == 0{
            Utilities.showAlertWithTitle(title: "Missing", withMessage: "Password is required", withNavigation: self)
            return
        }
        if company?.text?.count == 0{
            Utilities.showAlertWithTitle(title: "Missing", withMessage: "Number is required", withNavigation: self)
            return
        }
        var dic = Dictionary<String,AnyObject>()
        let method = "registerUser"
        dic["email"] = emailTxt?.text as AnyObject
        dic["password"] = password?.text as AnyObject
        dic["name"] = name.text as AnyObject
        dic["mobileNo"] = number.text as AnyObject
        dic["company"] = company.text as AnyObject
        Utilities.sharedInstance.showActivityIndicatory(uiView: self.view)
        ALFWebService.sharedInstance.doPostData(parameters: dic, method: method, success: { (response) in
            print(response)
            Utilities.sharedInstance.hideActivityIndicator(uiView: self.view)
            if let scode = response["status"] as? Int {
                if scode == 200 {
                    self.navigationController?.popViewController(animated: true)
                    
                } else  {
                    if let message = response["message"] as? Dictionary<String, AnyObject> {
                        let msg = message.first?.value
                        
                        Utilities.showAlertWithTitle(title: "Error", withMessage: msg  as! String, withNavigation: self)
                    }
                    
                }
            }
            
        }) { (response) in
            print(response)
        }
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
