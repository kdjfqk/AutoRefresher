//
//  ARConfigManager.swift
//  YNCCProduct
//
//  Created by ldy on 17/3/9.
//  Copyright © 2017年 YNKJMACMINI2. All rights reserved.
//

import Foundation

//MARK:- 自动刷新配置信息加载器需要实现的协议
protocol ARLoaderProtocol {
    var path:String{get set}
    func loadConfig()->[(String,String)]
}


public class ARConfigManager: NSObject {
    
    static public var plistPath:String = ""
    static public var defaultManager:ARConfigManager = ARConfigManager(loader:ARPlistLoader())
    fileprivate init(loader:ARLoaderProtocol) {
        super.init()
        //加载配置信息
        self.loader = loader
        self.loader.path = ARConfigManager.plistPath
        self.config = loader.loadConfig()
        //创建data center
        config.enumerated().forEach { (index: Int, element: (String, String)) in
            let dataCenter:AnyObject? = element.1.toObject()
            if dataCenter != nil && dataCenter is ARDCProtocol {
                self.dataCenters.append((element.0,element.1,dataCenter as! ARDCProtocol))
            }
        }
    }
    
    fileprivate var loader:ARLoaderProtocol!
    //配置信息字典，key为控制器类名，value为数据中心类名
    public var config:[(String,String)] = [("","")]
    //数据中心数组，每个item为元组，0为控制器类名，1为数据中心类名，2为数据中心对象
    var dataCenters:[(String,String,ARDCProtocol)] = [(String,String,ARDCProtocol)]()
}
