//
//  WJView.h
//  拖动的按钮
//
//  Created by wsj on 16/8/7.
//  Copyright © 2016年 wsj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJView : UIView
/***/
@property(nonatomic,strong)NSArray *buttons_array;
/***/
@property(nonatomic,copy)void(^myBlock)();
/**<#创建的界面tableView#>*/
@property(nonatomic,assign)CGFloat  buttonY;
/***/
@property(nonatomic,assign)CGFloat  buttonX;
@end
