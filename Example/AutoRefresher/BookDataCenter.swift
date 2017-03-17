//
//  BookDataCenter.swift
//  AutoRefresher
//
//  Created by ldy on 17/3/17.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import AutoRefresher

class BookDataCenter: NSObject, ARDCProtocol{
    func loadData(_ params: [String : AnyObject], complete: ((Bool, String?), AnyObject) -> Void) {
        params.enumerated().forEach { (offset: Int, element: (key: String, value: AnyObject)) in
            print("\(element.key):\(element.value)")
        }
        complete((true,nil), "图书" as AnyObject)
    }
}
