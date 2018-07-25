//
//  UploadVC.swift
//  Construction
//
//  Created by Mudassir Abbas on 30/06/2018.
//  Copyright © 2018 Mudassir Abbas. All rights reserved.
//

import UIKit

class UploadVC: UIViewController ,UIDocumentPickerDelegate,UIDocumentMenuDelegate{
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var measured: UITextField!
    @IBOutlet weak var back_date: UITextField!
    var params = Dictionary<String,AnyObject>()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ClickFileBtn(_ sender: UIButton)
    {
        let importMenu = UIDocumentPickerViewController(documentTypes: ["public.text", "public.data","public.pdf", "public.doc"], in: .import)
        importMenu.delegate = self
        present(importMenu, animated: true, completion: nil)
    }
    
    @IBAction func UploadFile(_ sender: UIButton)
    {
        if(name.text?.count == 0)
        {
            Utilities.showAlertWithTitle(title: "Missing", withMessage: "Name is required", withNavigation: self)
            return
        }
        if(measured.text?.count == 0)
        {
            Utilities.showAlertWithTitle(title: "Missing", withMessage: "Name is required", withNavigation: self)
            return
        }
        if(back_date.text?.count == 0)
        {
            Utilities.showAlertWithTitle(title: "Missing", withMessage: "Name is required", withNavigation: self)
            return
        }
        
        params["name"] = name.text as AnyObject
        params["measured"] = measured.text as AnyObject
        params["back_date"] = back_date.text as AnyObject
        let token = UserDefaults.standard.value(forKey: "token") as? String
       let method = "uploadVideo?token\(token!)"
        Utilities.sharedInstance.showActivityIndicatory(uiView: self.view)
        ALFWebService.sharedInstance.doPostData(parameters: params, method: method, success: { (response) in
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

    //MARK: - File Delegates
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        let cico = url as URL
        
        print("The Url is : \(cico)")
        print(controller.documentPickerMode)
        if controller.documentPickerMode == .import {
            
            let file_data = cico
            let fileName = cico.lastPathComponent
            if params["filename"] == nil {
                params["filename"] = cico.lastPathComponent as AnyObject
            }
        }
    }
    
    @available(iOS 8.0, *)
    
    public func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        
        documentPicker.delegate = self
        
        present(documentPicker, animated: true, completion: nil)
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
