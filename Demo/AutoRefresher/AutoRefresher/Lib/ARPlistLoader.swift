//
//  ARPlistLoader.swift
//  YNCCProduct
//
//  Created by ldy on 16/9/6.
//  Copyright © 2016年 YNKJMACMINI2. All rights reserved.
//

import UIKit

class ARPlistLoader: NSObject,ARLoaderProtocol {
    var path:String = ""
    func loadConfig()->[(String,String)] {
        var result:[(String,String)] = []
        let array:NSArray = NSArray(contentsOfFile: path)!
        for item in array {
            let dic:NSDictionary = item as! NSDictionary
            let key:String = dic.allKeys[0] as! String
            let value:String = dic[key] as! String
            result.append((key,value))
        }
        return result
    }
}
