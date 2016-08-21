//
//  MyHeadView.swift
//  PalyHigh
//
//  Created by wsj on 16/7/31.
//  Copyright © 2016年 wsj. All rights reserved.
//

import UIKit

class MyHeadView: UIView {

    var data_dict:[String:AnyObject]?
        {
        didSet{
            if let data_dict_ = data_dict
            {
                iconImageView.image = UIImage.shareImageClickHeadBorderWithImage(UIImage(named: data_dict_["image"] as! String), andSize: CGSizeMake(50,50), andBorderWidth: 2.0, andBorderColor: nil);
            }
      }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor();
        addSubview(iconImageView);
        addSubview(nameLable);
        
        addSubview(codeButton);
    }

    private lazy var iconImageView:UIImageView = {
        let imageView = UIImageView(frame: CGRectMake(10, 20, 50, 50));
        imageView.image = UIImage.shareImageClickHeadBorderWithImage(UIImage(named: "breaking_news_bkg_red"), andSize: CGSizeMake(50, 50), andBorderWidth: 2.0, andBorderColor: nil);
        return imageView;
    }()
    private lazy var nameLable:UILabel = {
        let lable = UILabel(frame: CGRectMake(CGRectGetMaxX(self.iconImageView.frame)+10, CGRectGetMinY(self.iconImageView.frame), 150, 25));
        lable.text = "七秒记忆鱼儿";
        lable.textColor = UIColor.whiteColor();
        return lable;
    }()
    private lazy var codeButton:UIButton = {
        let code = UIButton(frame: CGRectMake(kPalyhighWidth*0.8-50-10, CGRectGetMinY(self.iconImageView.frame), 50, 50));

        code.setBackgroundImage(UIImage.imageWithCode("七秒记忆鱼儿", height: 50), forState: .Normal);
        
        return code;
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
