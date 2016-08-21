//
//  MainTabbarVC.swift
//  PalyHigh
//
//  Created by wsj on 16/7/22.
//  Copyright © 2016年 wsj. All rights reserved.
//

import UIKit
//TODO: 我是七秒记忆鱼儿，如果在使用中出现的bug的话请联系593216709，期待你的指导，转载时请备注七秒记忆鱼儿
//TODO: 本工程为七秒记忆鱼儿著，转载请备注七秒记忆鱼儿。
//TODO: 本人简书地址为http://www.jianshu.com/users/e3402afea1f1/latest_articles
//TODO: 我们的swfit简书专题为http://www.jianshu.com/collection/e30d753afdee
//TODO: 我们的swfit交流群为512847147，iOS交流群为446310206欢迎大家一起讨论问题
public enum MainTabbarVCType
{
    case Normal
    case Rotat
}
class MainTabbarVC: UITabBarController {

    var tabbarStyle:MainTabbarVCType?
        {
        didSet{
            if tabbarStyle == .Rotat
            {
                tabBar.hidden = true;
                view.addSubview(dragButton);
                dragButton.myBlock = {(drag_button:DragButton)in
                    self.dragButtonClick(drag_button);
                    
                };
                NSNotificationCenter.defaultCenter().addObserver(self, selector: "getPushNotificationCenter", name: "push", object: nil);
                NSNotificationCenter.defaultCenter().addObserver(self, selector: "getPopNotificationCenter", name: "pop", object: nil);
            }
        }
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        dragView.myBlock = {()in()};
        dragButton.selected = false;
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = HomeViewController()
        addChildViewController(homeVC, imagename: "icon_0", selectedImage: "icon_0_select", title: "首页");
        let palyVC = PalyViewController()
        addChildViewController(palyVC, imagename: "icon_1", selectedImage: "icon_1_select", title: "游玩");
        let movieVC = ChatViewController();
        addChildViewController(movieVC, imagename: "icon_2", selectedImage: "icon_2_select", title: "聊天");
        let ktvVC = MoreViewController()
        addChildViewController(ktvVC, imagename: "icon_3", selectedImage: "icon_3_select", title: "更多");
        setUpTabbarTitle();
       
    }
    func setUpTabbarTitle(){
        // 设置默认情况下面字体的状态和大小
        var dict = [String:AnyObject]();
        dict[NSForegroundColorAttributeName] = UIColor.lightGrayColor();
        dict[NSFontAttributeName] = UIFont.systemFontOfSize(13);
         UITabBarItem.appearance().setTitleTextAttributes(dict, forState: .Normal);
        // 设置选中情况下面字体的状态和大小
        var dict_select = [String:AnyObject]();
        dict_select[NSForegroundColorAttributeName] = UIColor.orangeColor();
        dict_select[NSFontAttributeName] = UIFont.systemFontOfSize(13);
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orangeColor()], forState:UIControlState.Selected);
    }
    func addChildViewController(controller:UIViewController,imagename:String,selectedImage:String,title:String)
    {
        controller.tabBarItem.image = UIImage(named: imagename)?.imageWithRenderingMode(.AlwaysOriginal);
        controller.tabBarItem.selectedImage = UIImage(named: selectedImage)?.imageWithRenderingMode(.AlwaysOriginal);
        controller.title = title;
        
        let nav = MainNavigationVC(rootViewController:controller);
        self.addChildViewController(nav);
        
    }

    private lazy var dragButton:DragButton = {kPalyhighHeight
        let button = DragButton(frame: CGRectMake(kPalyhighWidth-10-50, 0.35*kPalyhighHeight, 50,50), addView: self.view);
        button.backgroundColor = UIColor.redColor();
        
        button.addTarget(self, action: "dragButtonClick:", forControlEvents: UIControlEvents.TouchUpInside);
        
        return button;
    }()
    func dragButtonClick(button:DragButton){
        
        button.selected = !button.selected;
        button.enabled = false;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.0   * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
            button.enabled = true;
        }
        var  wj_ViewX:CGFloat = 0.0;
        var  wj_ViewY:CGFloat = 0.0;
        if (button.x == 10) {
            wj_ViewX = button.x;
            
        }else{
            wj_ViewX = button.x-144;
        }
        if (button.y < 0.4*kPalyhighHeight) {
            wj_ViewY = button.y;
        }else{
            wj_ViewY = button.y-144;
        }
        
        if (button.selected) {
            
            dragView.buttonY = button.y;
            dragView.buttonX = button.x;
            dragView.x = wj_ViewX;
            dragView.y = wj_ViewY;
            dragView.buttons_array = [["name":"更多","icon":"icon_3"],["name":"聊天","icon":"icon_2"],["name":"游玩","icon":"icon_1"],["name":"首页","icon":"icon_0"]] as NSArray;
            view.addSubview(dragView)
            view.bringSubviewToFront(button);
        }else{
            dragView.myBlock = {()in()};

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
                self.dragView.removeFromSuperview();
            }
        }
        
    }
    private lazy var dragView:DragView = {
    
        let dragView = DragView(frame:CGRectMake(0, 0, 194, 194));
//        dragView.backgroundColor = UIColor.redColor();
        dragView.deleagte = self;
        return dragView;
    }()
    func getPushNotificationCenter(){
        
        dragButton.alpha = 0.0;
        dragView.alpha = 0.0;

        dragView.myBlock = {()in()};
        dragButton.selected = false;
        
    }
    func getPopNotificationCenter(){
        
        dragView.alpha = 1.0
        dragButton.alpha = 1.0;
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension MainTabbarVC:DragViewDeleagte
{
    func dragViewDidButtonClick(button: UIButton) {
         dragButtonClick(dragButton)
        switch(button.tag){
        case 998:
            self.selectedIndex = 3;
            break;
        case 999:
            self.selectedIndex = 2;
            break;
        case 1000:
            self.selectedIndex = 1;
            break;
        case 1001:
            self.selectedIndex = 0;
            break;
        default:
            self.selectedIndex = 0;
            break;
            
        }
    }
}
