//
//  MainVC.swift
//  PalyHigh
//
//  Created by wsj on 16/7/23.
//  Copyright © 2016年 wsj. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    var mainVC:UIViewController?
    var leftVC:UIViewController?
    var point = CGPointZero;
    var changePoint = CGPointZero;
    var openLeftVC:Bool = false;
    var tap:UITapGestureRecognizer?
    var pan:UIPanGestureRecognizer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(frame: CGRectMake(0, 0, kPalyhighWidth, kPalyhighHeight));
        imageView.image = UIImage(named: "ditu");
        view.addSubview(imageView);
        
         pan =  UIPanGestureRecognizer(target: self
            , action: "pan:")
        view.addGestureRecognizer(pan!);
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "getPushNotificationCenter", name: "push", object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "getPopNotificationCenter", name: "pop", object: nil);

    }
    func getPushNotificationCenter(){
        
        view.removeGestureRecognizer(pan!);
    }
    func getPopNotificationCenter(){
        
        view.addGestureRecognizer(pan!);
    }
    func initCreat(mainVC_:UIViewController?,leftVC_:UIViewController?)->UIViewController
    {
        mainVC = mainVC_;
        leftVC = leftVC_;
        leftVC_?.view.frame = CGRectMake(-0.4*kPalyhighWidth, 0, 0.8*kPalyhighWidth, kPalyhighHeight);
        view .addSubview((leftVC_?.view)!);
        leftVC_?.view.hidden = true;
        mainVC_?.view.frame = self.view.bounds;
        self.view .addSubview((mainVC_?.view)!);

        return self;
    }
    
    func pan(sender:UIPanGestureRecognizer) {

        if sender.state == .Began
        {
          leftVC?.view.hidden = false;
           point = sender.locationInView(self.view)
        }else if  sender.state == .Changed
        {
            changePoint = sender.locationInView(view);
            var width = changePoint.x - point.x;
           if openLeftVC == false
           {// 左视图还没显示出来
                if width <= 0 {
                    return ;
                }
                if width >= 0.8*kPalyhighWidth
                {// 判断是否越界
                    width = 0.8*kPalyhighWidth;
                }
                mainVC?.view.frame.origin.x = width
                leftVC?.view.center.x = width/2;
            
           }else{// 左视图显示出来了
                var width_ =  point.x - changePoint.x ;
                if width_ <= 0
                {
                    return;
                }
                if width_ >= 0.8*kPalyhighWidth
                {// 判断是否越界
                    width_ = 0.8*kPalyhighWidth;
                }
                mainVC?.view.frame.origin.x = 0.8*kPalyhighWidth - width_
                leftVC?.view.center.x = 0.4*kPalyhighWidth - width_/2;
            
                }
        } else if sender.state == .Ended
        {
            sender.setTranslation(CGPointZero, inView: view)
            //没有到达屏幕的一半
            if mainVC?.view.frame.origin.x < 0.5*kPalyhighWidth{
                openLeftVC = false;

                self.hiddenLeftView()
            }else {
                openLeftVC = true;
                self.showLeftView()
                
            }
        }
        
    }
    private lazy var rightView:UIView = {
        let rightView = UIView(frame: CGRectMake(0.8*kPalyhighWidth, 0, 0.2*kPalyhighWidth, kPalyhighHeight));
         self.tap = UITapGestureRecognizer(target: self, action: "tap:")
        rightView.addGestureRecognizer(self.tap!)
        return rightView;
    }()
    //收起左视图
    func hiddenLeftView(){
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.leftVC?.view.frame.size.width = kPalyhighWidth;
            self.leftVC?.view.frame.origin.x = -0.4*kPalyhighWidth
            self.mainVC?.view.frame.origin.x = 0;
            }) { (_) -> Void in
                self.leftVC?.view.hidden = true;
               self.rightView.removeFromSuperview();
        }
    }
    //显示左视图
    func showLeftView() {

        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.leftVC?.view.frame.size.width = kPalyhighWidth*0.8;
            self.leftVC?.view.frame.origin.x = 0
            self.mainVC?.view.frame.origin.x = 0.8*kPalyhighWidth;
            }) { (_) -> Void in
                self.view.addSubview(self.rightView)
        }
    }

    //点击还原手势
    func tap(sender: UITapGestureRecognizer) {
        openLeftVC = false;
        hiddenLeftView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
