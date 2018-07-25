//
//  FileModel.swift
//  Construction
//
//  Created by Mudassir Abbas on 30/06/2018.
//  Copyright © 2018 Mudassir Abbas. All rights reserved.
//

import UIKit

class FileModel: NSObject {

    var name = ""
    var userId: Int!
    var file_title = ""
    var file_id:Int!
    var file_url = ""
    var create = ""
    var measured = ""
    var back_date = ""
    convenience init(_ dictionary: Dictionary<String, AnyObject>) {
        self.init()
        if !(dictionary["name"] is NSNull) && (dictionary["name"] != nil){
            
            name = dictionary["name"] as! String
        }
        if !(dictionary["user_id"] is NSNull) && (dictionary["user_id"] != nil){
            
            userId = dictionary["user_id"] as? Int
        }
        if !(dictionary["file_title"] is NSNull) && (dictionary["file_title"] != nil){
            
            file_title = dictionary["file_title"] as! String
        }
        if !(dictionary["file_id"] is NSNull) && (dictionary["file_id"] != nil){
            
            file_id = dictionary["file_id"] as? Int
        }
        if !(dictionary["file_url"] is NSNull) && (dictionary["file_url"] != nil){
            
            file_url = dictionary["file_url"] as! String
        }
        if !(dictionary["creation_date"] is NSNull) && (dictionary["creation_date"] != nil){
            
            create = dictionary["creation_date"] as! String
        }
        if !(dictionary["measured"] is NSNull) && (dictionary["measured"] != nil){
            
            measured = dictionary["measured"] as! String
        }
        if !(dictionary["back_date"] is NSNull) && (dictionary["back_date"] != nil){
            
            back_date = dictionary["back_date"] as! String
        }
    }

}

