//
//  UIImage+ClickImage.h
//  Quartz2D
//
//  Created by wsj on 16/7/9.
//  Copyright © 2016年 wsj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ClickImage)
/**
 *  设置裁剪圆形图片
 *
 *  @param image 设置裁剪的图片
 *  @param size  设置裁剪的区域
 *
 *  @return 反悔裁剪完的图片
 */
+(UIImage *)shareImageClickHeadBorderWithImage:(UIImage *)image andSize:(CGSize)size;
/**
 *  设置带有边框的裁剪圆图片
 *
 *  @param image       要裁剪的图片
 *  @param size        裁剪的尺寸
 *  @param borderWidth 边框的宽度
 *  @param color       边框的颜色
 *
 *  @return 反悔裁剪好的图片
 */
+(UIImage *)shareImageClickHeadBorderWithImage:(UIImage *)image andSize:(CGSize)size andBorderWidth:(CGFloat)borderWidth andBorderColor:(UIColor *)color;
/**
 *  截取屏幕为图片
 *
 *  @param view 需要截屏的view
 *
 *  @return 返回一个图片
 */
+(UIImage *)shareImageWithCaputureView:(UIView *)view;
/**
 *  任意剪切view上面四个角的圆角
 *
 *  @param view    需要剪切的view
 *  @param corners 需要剪切的那个角
 *  @param radius  剪切的弧度
 *
 */
+(void)shearRoundedCornersWithView:(UIView *)view andRoundingCorners:(UIRectCorner)corners andRadius:(CGFloat)radius;
@end
