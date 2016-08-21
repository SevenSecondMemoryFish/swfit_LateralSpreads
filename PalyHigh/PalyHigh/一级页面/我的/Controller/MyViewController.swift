//
//  MyViewController.swift
//  PalyHigh
//
//  Created by wsj on 16/7/23.
//  Copyright © 2016年 wsj. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(myHeadView);
        view.addSubview(tableView);
        
    }

    private lazy var tableView:UITableView = {
        let tableView = UITableView(frame: CGRectMake(0, CGRectGetMaxY(self.myHeadView.frame), kPalyhighWidth, kPalyhighHeight-64), style: UITableViewStyle.Plain);
        tableView.backgroundColor = UIColor.clearColor();
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
        tableView.delegate = self;
        tableView.dataSource = self;
        
        return tableView;
    }()
    private lazy var myHeadView:MyHeadView = {
        let headView = MyHeadView(frame: CGRectMake(0, 64, self.view.width, 150));
        return headView;
    }()
    private lazy var data_array :[[String:String]]={
        let array = [["name":"我的资料","icon":""],["name":"我的收藏","icon":""],["name":"我的订单","icon":""]];
        return array;
    
    }()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension MyViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data_array.count ?? 0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell = MyMaterialCell.shareTableView(tableView)
        cell.data_dict = data_array[indexPath.row];
//        cell.backgroundColor = UIColor.blueColor();
        return cell;
        
    }
    
}