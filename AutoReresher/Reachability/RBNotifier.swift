//
//  RBNotifier.swift
//  GHCentralizedControl
//
//  Created by YNKJMACMINI2 on 16/2/16.
//  Copyright © 2016年 YNKJMACMINI2. All rights reserved.
//

import UIKit


//Notification
let kNetReachabilityChangedNotification:String = "NetReachabilityChangedNotification"
let kNetReachabilityChangedNotificationUserInfoReachableKey:String = "Reachable"

class RBNotifier: NSObject {

    //IP or 域名，不可带http://
    static var severHost:String = ""
    //获取单例
    static let sharedInstance = RBNotifier()
    //控制开启和停止监听，并接受网络改变通知
    var reach:Reachability!
    //记录当前网络状态
    var currentNetReachable:Bool!
    
    fileprivate override init()
    {
        super.init()
        self.reach = Reachability(hostName: RBNotifier.severHost)
        self.currentNetReachable = ReachabilityUtil.isReachable(RBNotifier.severHost)
        NotificationCenter.default.addObserver(self, selector: #selector(RBNotifier.reachabilityChanged(_:)), name: NSNotification.Name.reachabilityChanged, object: nil)
    }
    
    //开始监听
    func start()
    {
        self.reach.startNotifier()
    }
    //停止监听
    func stop()
    {
        self.reach.stopNotifier()
    }
    
    func reachabilityChanged(_ noti:Notification)
    {
        //print("\(self.reach.currentReachabilityStatus)")
        let newReachable:Bool = ReachabilityUtil.isReachable(RBNotifier.severHost)
        if newReachable != self.currentNetReachable {
            if newReachable {
                print("网络已连接")
                NotificationCenter.default.post(name: Notification.Name(rawValue: kNetReachabilityChangedNotification), object: nil, userInfo: [kNetReachabilityChangedNotificationUserInfoReachableKey:true])
            }
            else{
                print("网络已断开")
                NotificationCenter.default.post(name: Notification.Name(rawValue: kNetReachabilityChangedNotification), object: nil, userInfo: [kNetReachabilityChangedNotificationUserInfoReachableKey:false])
            }
            self.currentNetReachable = newReachable
        }
    }
}
