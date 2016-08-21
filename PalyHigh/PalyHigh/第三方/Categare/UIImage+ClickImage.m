//
//  UIImage+ClickImage.m
//  Quartz2D
//
//  Created by wsj on 16/7/9.
//  Copyright © 2016年 wsj. All rights reserved.
//

#import "UIImage+ClickImage.h"

@implementation UIImage (ClickImage)
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

+(UIImage *)shareImageClickHeadBorderWithImage:(UIImage *)image andSize:(CGSize)size andBorderWidth:(CGFloat)borderWidth andBorderColor:(UIColor *)color
{
    CGFloat imageWH = 0;
    CGFloat border = 0;
    imageWH = size.height != 0 || size.width == 0 ? size.height : image.size.height;
    border = borderWidth != 0 ? borderWidth :2;
    CGFloat image_bored = imageWH+2*border;
    // 开启一个图片上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(image_bored, image_bored), NO, 0);
    // 设置大圆的裁剪区域  只是画了个圆而已
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image_bored, image_bored)];
    // 填充的颜色
    [color != nil ? color :[UIColor redColor] set ];
    [path fill];
    // 设置裁剪内圆的路径
    UIBezierPath *clicp_path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(border, border, imageWH, imageWH)];
    [clicp_path addClip];
    [clicp_path fill];
    // 图片绘制到内圆的区域
    [image drawInRect:CGRectMake(border, border, imageWH, imageWH)];
    // 得到图片上下文
    UIImage *imageClick = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return imageClick;
}
/**
 *  设置裁剪圆形图片
 *
 *  @param image 设置裁剪的图片
 *  @param size  设置裁剪的区域
 *
 *  @return 反悔裁剪完的图片
 */
+(UIImage *)shareImageClickHeadBorderWithImage:(UIImage *)image andSize:(CGSize)size
{
    CGFloat imageWH = 0;
    imageWH = size.height != 0 || size.width == 0 ? size.height : image.size.height;
    // 开启一个图片上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWH, imageWH), NO, 0);
    // 设置裁剪的路径
    UIBezierPath *clicp_path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, imageWH, imageWH)];
    [clicp_path addClip];
    // 图片绘制到内圆的区域
    [image drawInRect:CGRectMake(0, 0, imageWH, imageWH)];
    // 得到图片上下文
    UIImage *imageClick = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return imageClick;
}
/**
 *  截取屏幕为图片
 *
 *  @param view 需要截屏的view
 *
 *  @return 返回一个图片
 */
+(UIImage *)shareImageWithCaputureView:(UIView *)caputureView
{
    NSLog(@"%@",NSStringFromCGRect(caputureView.bounds));
    // 开启一个图形上下文
    UIGraphicsBeginImageContextWithOptions(caputureView.bounds.size, NO, 0);
    // 获取到这个上下wen
    CGContextRef con = UIGraphicsGetCurrentContext();
    // 将View的图形渲染到上下文中  ,layer不能绘制到上下文中，只能渲染到上下文中
    [caputureView.layer renderInContext:con];
    // 得到绘制好的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
    
}
/**
 *  任意剪切view上面四个角的圆角
 *
 *  @param view    需要剪切的view
 *  @param corners 需要剪切的那个角
 *  @param radius  剪切的弧度
 *
 */
+(void)shearRoundedCornersWithView:(UIView *)view andRoundingCorners:(UIRectCorner)corners andRadius:(CGFloat)radius
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *shape = [[CAShapeLayer alloc]init];
    shape.path = path.CGPath;
    view.layer.mask = shape;
    
}
@end
