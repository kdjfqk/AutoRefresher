//
//  ViewController.swift
//  AutoRefresher
//
//  Created by kdjfqk on 03/17/2017.
//  Copyright (c) 2017 kdjfqk. All rights reserved.
//

import UIKit
import AutoRefresher

class ViewController: UIViewController,ARProtocol {

    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //ARManager.setAutoRefreshHook()
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- ARProtocol
    func requestParam(_ dcClass: AnyClass) -> [String : AnyObject] {
        return ["userName":"wangling" as AnyObject]
    }
    
    func updateData(_ data: AnyObject, fromDC: AnyClass) {
        if fromDC == BookDataCenter.self {
            let str = data as! String
            label.text = str
            print(str)
        }
    }

}

