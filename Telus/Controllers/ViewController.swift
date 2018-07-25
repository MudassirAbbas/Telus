//
//  ViewController.swift
//  Construction
//
//  Created by Mudassir Abbas on 30/06/2018.
//  Copyright © 2018 Mudassir Abbas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        modalView.frame = CGRect(x: 15, y: self.view.frame.width / 2, width: (self.view.frame.width) - 30, height: 250)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
//        self.view.addSubview(modalView)
    }
    override func dismissKeyboard() {
        modalView.removeFromSuperview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func ShowModel(_ sender: UIButton)
    {
        self.view.addSubview(modalView)
    }
    @IBAction func OpenSignup(_ sender: UIButton)
    {
        let vc = UIStoryboard.storyBoard(withName: .Main).loadViewController(withIdentifier: .signUpVC) as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signInBtnClicked(_ sender: Any) {
        self.view.endEditing(true)
        if emailTxt?.text?.count == 0{
            Utilities.showAlertWithTitle(title: "Missing", withMessage: "Email is required", withNavigation: self)
            return
        }else
        {
            if !(isValidEmail(testStr: (emailTxt?.text)!))
            {
                Utilities.showAlertWithTitle(title: "Validation", withMessage: "Enter Valid Email", withNavigation: self)
                return
            }
        }
        if(passwordTxt?.text?.count == 0)
        {
            Utilities.showAlertWithTitle(title: "Missing", withMessage: "Password is required", withNavigation: self)
            return
        }else if ((passwordTxt?.text?.count)! < 6)
        {
            Utilities.showAlertWithTitle(title: "Validation", withMessage: "Password must be at least 6 characters", withNavigation: self)
            return
        }
        var dic = Dictionary<String,AnyObject>()
        let method = "tryLogin"
        dic["email"] = emailTxt?.text as AnyObject
        dic["password"] = passwordTxt?.text as AnyObject
        dic["ip"] = "127.0.0.1" as AnyObject
        dic["device_type"] = "ios" as AnyObject
        print(dic)
        Utilities.sharedInstance.showActivityIndicatory(uiView: self.view)
        ALFWebService.sharedInstance.doPostData(parameters: dic, method: method, success: { (response) in
            
            print(response)
            Utilities.sharedInstance.hideActivityIndicator(uiView: self.view)
            if let scode = response["status"] as? Int {
                if scode == 200 {
                let token = response["token"] as? String
                        UserDefaults.standard.set(token, forKey: "token")
                        if let user = response["user"] as? Dictionary<String, AnyObject> {
                            let id = user["id"] as? Int
                            UserDefaults.standard.set(id, forKey: "id")
                            let email = user["email"] as? String
                            UserDefaults.standard.set(email, forKey: "email")
                            let name = user["name"] as? String
                            UserDefaults.standard.set(name, forKey: "name")
                            let number = user["mobileNo"] as? String
                            UserDefaults.standard.set(number, forKey: "number")
                            let company = user["company"] as? String
                            UserDefaults.standard.set(company, forKey: "company")
                            let app = UIApplication.shared.delegate as! AppDelegate
                            app.CheckLogin()
                        }
                    
                }
                else {
                    if let message = response["message"] as? String {
                        Utilities.showAlertWithTitle(title: "Error", withMessage: message, withNavigation: self)
                    }
                    
                }
            }
            
        }) { (response) in
            print(response)
        }
        
    }
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }


}

