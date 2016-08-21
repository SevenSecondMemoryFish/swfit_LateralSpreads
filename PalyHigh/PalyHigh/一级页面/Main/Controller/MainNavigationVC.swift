//
//  MainNavigationVC.swift
//  PalyHigh
//
//  Created by wsj on 16/7/22.
//  Copyright © 2016年 wsj. All rights reserved.
//

import UIKit
//TODO: 本工程为七秒记忆鱼儿著，转载请备注七秒记忆鱼儿。
//TODO: 本人简书地址为http://www.jianshu.com/users/e3402afea1f1/latest_articles
//TODO: 我们的swfit简书专题为http://www.jianshu.com/collection/e30d753afdee
//TODO: 我们的swfit交流群为512847147，iOS交流群为446310206欢迎大家一起讨论问题
class MainNavigationVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.translucent = false;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0
        {
//            viewController.hidesBottomBarWhenPushed = true;
        }else {
            
        }
    NSNotificationCenter.defaultCenter().postNotificationName("push", object: self);
        
        super.pushViewController(viewController, animated: true);
       
    }
    override func popViewControllerAnimated(animated: Bool) -> UIViewController? {
        
        NSNotificationCenter.defaultCenter().postNotificationName("pop", object: self);
        super.popViewControllerAnimated(true);
        return viewControllers.last;
    }
    
}
