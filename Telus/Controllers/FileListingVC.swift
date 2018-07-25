//
//  FileListingVC.swift
//  Construction
//
//  Created by Mudassir Abbas on 30/06/2018.
//  Copyright © 2018 Mudassir Abbas. All rights reserved.
//

import UIKit
import Alamofire

class FileListingVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var files = [FileModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 112
        LoadFiles()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.files.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FileCell", for: indexPath) as! FileCell
        let model = self.files[indexPath.row]
        cell.name.text = model.name
        cell.measured.text = model.measured
        cell.back_date.text = model.back_date
        cell.downloadBtn.tag = indexPath.row
        cell.downloadBtn.addTarget(self, action: #selector(self.FileBtnClicked(_:)), for: .touchUpInside)
        return cell
    }
    func LoadFiles()
    {
         let token = UserDefaults.standard.value(forKey: "token") as? String
        let method = "/allVideosList?token=\(token!)"
        var param = Dictionary<String,AnyObject>()
        param["token"] = token!  as AnyObject
        param["limit"] = 10 as AnyObject
        param["page"] = 1 as AnyObject
        Utilities.sharedInstance.showActivityIndicatory(uiView: self.view)
//        ALFWebService.sharedInstance.doGetData(parameters: param, method: method, success: { (response) in
//            Utilities.sharedInstance.hideActivityIndicator(uiView: self.view)
//            print(response)
//            if let scode = response["status"] as? Int {
//                if scode == 200 {
//                    if let fileArr = response["videos"] as? [Dictionary<String,AnyObject>]{
//                        for file in fileArr{
//                            let model = FileModel.init(file)
//                            self.files.append(model)
//                        }
//                        self.tableView.reloadData()
//                    }
//
//                }
//                else {
//                    if let message = response["message"] as? String {
//                        Utilities.showAlertWithTitle(title: "Error", withMessage: message, withNavigation: self)
//                    }
//
//                }
//            }
//        }, fail: { (response) in
//            print(response)
//        })
        let url = "http://quaid.website/continental/public/api/allVideosList?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX3R5cGUiOiJ1c2VyIiwic3ViIjoxNiwiaXNzIjoiaHR0cDovL3F1YWlkLndlYnNpdGUvY29udGluZW50YWwvcHVibGljL2FwaS90cnlMb2dpbiIsImlhdCI6MTUzMDM3MTc3MSwiZXhwIjoxNTMzOTcxNzcxLCJuYmYiOjE1MzAzNzE3NzEsImp0aSI6IlF1eUJBU1NGTGtMTzFnZlgifQ.YaJWfNTs1n4amW3cvwD9LYeWA0WQl39ezjqGHc999n0"
        let headers: HTTPHeaders = [
            "Authorization": "Info XXX",
            "Accept": "application/json",
            "Content-Type" :"application/json"
        ]
        
        let parameters:Parameters = [
            "items": [
                "token" : token!,
            ]
        ]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: headers).responseJSON { (response) in
            print(response)
            let data = response.result.value as? Dictionary<String,AnyObject>
            Utilities.sharedInstance.hideActivityIndicator(uiView: self.view)
            if let scode = data!["status"] as?  Int {
                            if scode == 200 {
                                if let fileArr = data!["videos"] as? [Dictionary<String,AnyObject>]{
                                    for file in fileArr{
                                        let model = FileModel.init(file)
                                        self.files.append(model)
                                    }
                                    self.tableView.reloadData()
                                }
            
                            }
                            else {
                                if let message = data!["message"] as? String {
                                    Utilities.showAlertWithTitle(title: "Error", withMessage: message, withNavigation: self)
                                }
            
                            }
                        }
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
    
    @IBAction func FileBtnClicked(_ sender: UIButton)
    {
        let model = files[sender.tag]
        let urlStr = model.file_url
        
        // Converting string to URL Object
        let url = URL(string: urlStr)
        
        // Get the PDF Data form the Url in a Data Object
        let pdfData = try? Data.init(contentsOf: url!)
        
        // Get the Document Directory path of the Application
        let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
        
        // Split the url into a string Array by separator "/" to get the pdf name
        let pdfNameFromUrlArr = urlStr.components(separatedBy: "/")
        
        // Appending the Document Directory path with the pdf name
        let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrlArr[
            pdfNameFromUrlArr.count - 1])
        
        // Writing the PDF file data to the Document Directory Path
        do {
            _ = try pdfData?.write(to: actualPath, options: .atomic)
        }catch{
            
            print("Pdf can't be saved")
        }
        
        // Showing the pdf file name in a label
//        lblPdfName.text = pdfNameFromUrlArr[pdfNameFromUrlArr.count - 1]
        
        // URLRequest for the PDF file saved in the Document Directory folder
//        let urlRequest = URLRequest(url: actualPath)
//
//        webVw.isUserInteractionEnabled = true
//        webVw.delegate = self
//        webVw.loadRequest(urlRequest)
    }
}
