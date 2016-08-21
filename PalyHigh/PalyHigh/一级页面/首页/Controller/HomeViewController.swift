//
//  HomeViewController.swift
//  PalyHigh
//
//  Created by wsj on 16/7/22.
//  Copyright © 2016年 wsj. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    // MARK: -- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
          self.automaticallyAdjustsScrollViewInsets = false

         view.backgroundColor = UIColor.yellowColor();
        
        view.addSubview(button)
    }
    private lazy var button:UIButton = {
        let button = UIButton(frame: CGRectMake(100, 100, 100, 100));
        button.setTitle("进入下一页", forState: UIControlState.Normal);
        button.backgroundColor = UIColor.redColor()
        button.addTarget(self, action: "buttonClick", forControlEvents: UIControlEvents.TouchUpInside);
        return button;
    }()
    func buttonClick(){
        let oneVc = OneViewController();
//TODO: 如果使用默认模式的话push之前可以在这里把tabar隐藏，也是可以在主导航控制器里面隐藏吊，全换的时候可以发通知显示出来，本人比较懒就允许了这个bug的存在
        navigationController?.pushViewController(oneVc, animated: true);
    }
   
}
