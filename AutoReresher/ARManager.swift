//
//  ARManager.swift
//  ARManager
//
//  Created by ldy on 17/3/9.
//  Copyright © 2017年 ARKJMACMINI2. All rights reserved.
//

import UIKit
import Aspects

let AutoRefreshNotification:String = "AutoRefresh"  //自动刷新通知

//MARK:- 控制器需要实现的自动刷新协议
@objc public protocol ARProtocol {
    
    /**
     获取请求参数
     - parameter dcClass: 数据中心类型
     - returns: 参数字典，key为参数名，value为参数值
     */
    func requestParam(_ dcClass:AnyClass) -> [String:AnyObject]
    
    /**
     更新数据
     - parameter data: 新数据
     - parameter fromDC: 产生新数据的数据中心类型
     - returns: 无
     */
    func updateData(_ data:AnyObject,fromDC:AnyClass) -> Void
}

//MARK:- 数据中心需要实现的自动刷新协议
public protocol ARDCProtocol {
    
    /**
     加载数据
     - parameter params:   参数字典，key为参数名，value为参数值
     - parameter complete: 加载成功后的回调
     */
    func loadData(_ params:[String:AnyObject], complete:((Bool,String?),AnyObject)->Void)
    
}


public class ARManager:NSObject,IAutoRefreshManager {
    
    func loadData() {
        //通知各VC执行刷新
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AutoRefreshNotification), object: nil)
    }
    //注册自动刷新
    public class func setAutoRefreshHook() {
        let wrappedBlock:@convention(block) (AnyObject)->Void = {(info)->Void in
            let vc:UIViewController = info.instance() as! UIViewController
            if vc is ARProtocol {
                NotificationCenter.default.addObserver(vc, selector: #selector(vc.didReceiveAutoRefreshNotification(notif:)), name: NSNotification.Name(rawValue: AutoRefreshNotification), object: nil)
            }
        }
        do {
            try UIViewController.aspect_hook(#selector(UIViewController.viewDidLoad), with: AspectOptions.init(rawValue: 0), usingBlock: unsafeBitCast(wrappedBlock, to: AnyObject.self))
        }catch{
        }
    }
}

extension UIViewController{
    //自动刷新通知处理函数
    func didReceiveAutoRefreshNotification(notif:NSNotification){
        let dc = ARConfigManager.defaultManager.dataCenters
        dc.enumerated().forEach { (index: Int, element: (String, String, ARDCProtocol)) in
            if self.isKind(of: element.0.toClass()!) {
                if self is ARProtocol {
                    let params:[String:AnyObject] = (self as! ARProtocol).requestParam(element.1.toClass()!)
                    element.2.loadData(params, complete: { (success: (isSuccess:Bool,message:String?), data:AnyObject) in
                        if success.isSuccess {
                            (self as! ARProtocol).updateData(data, fromDC: element.1.toClass()!)
                        }
                    })
                }
            }
        }
    }
}
