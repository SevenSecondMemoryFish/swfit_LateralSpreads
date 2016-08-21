//
//  AppDelegate.swift
//  PalyHigh
//
//  Created by wsj on 16/7/22.
//  Copyright © 2016年 wsj. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

//    var window: UIWindow?

//
//    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//        
//        window = UIWindow(frame:UIScreen.mainScreen().bounds)
//        window?.backgroundColor = UIColor.whiteColor();
//        let mainVc:UIViewController = MainTabbarVC();
//        let leftVC:UIViewController = MyViewController();
////        MainVC().initCreat(mainVc, leftVC: leftVC);
//        window?.rootViewController = MainVC().initCreat(mainVc, leftVC_: leftVC);
//        window?.makeKeyAndVisible();
//        
//        /**
//        Bmob register
//        */
//        Bmob.registerWithAppKey(bmobAppID);
//        
//        return true
//    }
    
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame:UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor();
        let mainVc = MainTabbarVC();
//TODO: 更选你需要的结构 Rotat表示+号结构  Normal表示默认的tabbar结构
        mainVc.tabbarStyle = .None;
        let leftVC:UIViewController = MyViewController();
        window?.rootViewController = MainVC().initCreat(mainVc, leftVC_: leftVC);
        window?.makeKeyAndVisible();

        return true
        
    }
    
    


}

