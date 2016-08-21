//
//  MyMaterialCell.swift
//  PalyHigh
//
//  Created by wsj on 16/7/31.
//  Copyright © 2016年 wsj. All rights reserved.
//

import UIKit
let wj_cell = "wj_cell";
class MyMaterialCell: UITableViewCell {

    var data_dict:[String:String]?
        {
        // set方法
            didSet{
                if let data_dict_ = data_dict
                {
                    iconImageView.image = UIImage(named: data_dict_["icon"]!);
                    nameLable.text = data_dict_["name"]!;
                }
        }
    }
    class func shareTableView(tableView:UITableView)->MyMaterialCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(wj_cell) as? MyMaterialCell;
        
        if cell == nil{
            cell = MyMaterialCell(style: .Default, reuseIdentifier: wj_cell);
            cell?.backgroundColor = UIColor.clearColor();
        }
        return cell!;
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
            contentView.addSubview(iconImageView);
            contentView.addSubview(nameLable);
      }

    private lazy var iconImageView:(UIImageView) = UIImageView()
    private lazy var nameLable:UILabel = {
        let label = UILabel();
        label.textColor = UIColor.whiteColor()
        return label;
    }()
    
    override func layoutSubviews() {
//        super.layoutSubviews()
        iconImageView.frame = CGRectMake(20, 0,30 , 30);
        nameLable.frame = CGRectMake(CGRectGetMaxX(iconImageView.frame)+10, (CGRectGetHeight(self.frame)-25)/2, 100, 25);
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
