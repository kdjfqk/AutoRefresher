//
//  ARefresher.swift
//  GHCentralizedControl
//
//  Created by ARKJMACMINI2 on 16/3/3.
//  Copyright © 2016年 ARKJMACMINI2. All rights reserved.
//

import UIKit

//数据中心 接口
protocol IAutoRefreshManager:NSObjectProtocol{
    func loadData()
}

//刷新器，内部实现需要用到UTimer类和RBNotifier类
public class ARefresher: NSObject ,UTimerProtocol{
    
    static public let sharedInstance = ARefresher()
    //只读属性state
    public var state:TimerState{
        return self.timer.state
    }
    fileprivate var timer:UTimer!
    fileprivate var manager:IAutoRefreshManager?
    fileprivate var isRefreshing:Bool = false
    
    //初始化
    fileprivate override init() {
        super.init()
        self.timer = UTimer.init(refreshInterval: TimeInterval(15))
        self.timer.delegate = self
        self.manager = ARManager()
        ARManager.setAutoRefreshHook()
    }
//    //设置数据中心
//    public func setManager(_ manager:IAutoRefreshManager)->ARefresher{
//        self.manager = manager
//        return self
//    }
    
    //设置配置文件路径
    public func setPlistPath(_ path:String)->ARefresher{
        ARConfigManager.plistPath = path
        return self
    }
    //设置刷新时间
    public func setRefreshTime(_ time:Float)->ARefresher
    {
        self.timer.changedInterval(TimeInterval(time))
        return self
    }
    //设置服务器host
    public func setSeverHost(_ host:String)->ARefresher
    {
        RBNotifier.severHost = host
        return self
    }
    //开启
    public func start()
    {
        //self.timer.start()
        self.timer.startAfterInterval()
        self.isRefreshing = true
    }
    //停止
    public func stop()
    {
        self.timer.stop()
        self.isRefreshing = false
    }
    
    // MARK: - UTimerProtocol
    public func doTimerTask(){
        self.loadData()
    }
    
    //网络状态改变通知
    func reachabilityChanged(_ noti:Notification){
        let newreachability = ((noti as NSNotification).userInfo! as NSDictionary).object(forKey: kNetReachabilityChangedNotificationUserInfoReachableKey) as! Bool
        if newreachability {  //若网络已连接
            //停止监听网络状态
            RBNotifier.sharedInstance.stop()
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: kNetReachabilityChangedNotification), object: nil)
            //开启刷新
            if self.isRefreshing{
                self.start()
            }
        }
    }
    
    //MARK: - private
    fileprivate func loadData(){
        print(Date())
        print("ARefresher.loadData()")
        if ReachabilityUtil.isReachable(RBNotifier.severHost) {  //有网
            guard let m = self.manager else {
                return
            }
            m.loadData()
        }
        else{  //无网
            //停止刷新
            self.timer.stop()
            //开始监听网络状态
            RBNotifier.sharedInstance.start()
            NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged(_:)), name: NSNotification.Name(rawValue: kNetReachabilityChangedNotification), object: nil)
        }
    }
}
