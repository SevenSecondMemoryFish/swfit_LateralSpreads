//
//  DragView.swift
//  PalyHigh
//
//  Created by wsj on 16/8/8.
//  Copyright © 2016年 wsj. All rights reserved.
//

import UIKit
public enum DragViewStyle// 枚举  没用到哈哈但是可以学习
{
    case Home
    case Play
    case Chat
    case More
}

protocol DragViewDeleagte:NSObjectProtocol
{
    func dragViewDidButtonClick(button:UIButton);
}
class DragView: UIView {
    var buttonX:CGFloat = 0
    var buttonY:CGFloat = 0
    let Radius:CGFloat = 150;
    let Padding:CGFloat = 150 - 50.0
    let MaxWidth:CGFloat = 194;
    var angle:Double = 0.0;
    var current_button:UIButton?
    weak var deleagte:DragViewDeleagte?// 弱引用
    var myBlock:(()->())?
        {
            didSet{
                setMyBlock();
        }
    }
    var buttons_array:NSArray?
        {
            didSet{
                if let buttonsArray = buttons_array
                {
                     angle = M_PI/2/Double(buttonsArray.count - 1);
                     self.setButtons_array(buttonsArray, angle: angle);
                }
                
            }
    }
    
    private func setButtons_array(array:NSArray,angle:Double){
        
        if self.subviews.count == 0
        {
            for var index in 0..<array.count
            {
                print(index);
                let button = UIButton(frame: CGRectMake(0, 0, 44, 44));
                let dict = array[index] as![String:String];
                
                button.setImage(UIImage(named:dict["icon"]!), forState:.Normal);
                button.setImage(UIImage(named:"\(dict["icon"]!)_select" ), forState: UIControlState.Selected);
                button.setTitle(dict["name"]!, forState: .Normal);
                button.backgroundColor = UIColor.whiteColor();
                button.setTitleColor(UIColor.blackColor(), forState: .Normal)
                button.setTitleColor(UIColor.redColor(), forState: .Selected);
                button.titleLabel?.font = UIFont.systemFontOfSize(10);
                button.tag = 998+index;
                button.addTarget(self, action: "buttonClick:", forControlEvents: UIControlEvents.TouchUpInside);
                button.titleEdgeInsets = UIEdgeInsetsMake(15, -25, -15, 0);
                button.imageEdgeInsets = UIEdgeInsetsMake(-5, 5, 5, -5);
                button.layer.cornerRadius = 22;
                button.layer.masksToBounds = true;
                if index == 3{
                    current_button = button;
                    button.selected = true;
                }
                button.enabled = false;
                starAnimattion(button,index: index)
                self.addSubview(button);
            }
        }else{
            for var index in 0..<self.subviews.count
            {
                let button = self.subviews[index] as! UIButton;
               starAnimattion(button,index: index)
            }
        }
    }
    func buttonClick(button:UIButton){
        
        current_button?.selected = false;
        button.selected = true;
        current_button = button;
        self.deleagte?.dragViewDidButtonClick(button)

    }
    private func starAnimattion(button:UIButton,index:Int){
        let animation_one = CAKeyframeAnimation(keyPath: "position");
        animation_one.values = getAnimationValues(button, angle: angle, index: Double(index)) as [AnyObject];
        animation_one.duration = 1.0;
        
        let animatetionTwo = CAKeyframeAnimation(keyPath: "transform.scale");
        
        animatetionTwo.duration = 1.0;
        animatetionTwo.values = [0.0,0.2,0.4,0.6,0.8,1.0];
        
        let animatetion_three = CABasicAnimation(keyPath: "transform.rotation.z");
        animatetion_three.duration = 1.0;
        animatetion_three.toValue = NSNumber(double: 4.0*M_PI);
        
        let   group = CAAnimationGroup();
        group.animations = [animation_one,animatetionTwo,animatetion_three];
        group.duration = 1.0;
        group.removedOnCompletion = false;
        group.fillMode = kCAFillModeForwards;
        button.layer.addAnimation(group, forKey: nil);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
            button.enabled = true;
        }
    }
    private func setMyBlock(){
        
        if let buttonsArray = buttons_array
        {
            for var index in 0..<buttonsArray.count
            {
                let button = self.subviews[index] as! UIButton;
                
                let animation_one = CAKeyframeAnimation(keyPath: "position");
                let array = getAnimationValues(button, angle: angle, index: Double(index)) as [AnyObject];
                animation_one.values = [array.last!,array.first!];
                animation_one.duration = 1.0;
                
                let animatetionTwo = CAKeyframeAnimation(keyPath: "transform.scale");
                
                animatetionTwo.duration = 1.0;
                
                animatetionTwo.values = [1.0,0.8,0.6,0.4,0.2,0.0];
                
                let animatetion_three = CABasicAnimation(keyPath: "transform.rotation.z");
                animatetion_three.duration = 1.0;
                animatetion_three.toValue = NSNumber(double: 4.0*M_PI);
                
                let   group = CAAnimationGroup();
                group.animations = [animation_one,animatetionTwo,animatetion_three];
                group.duration = 1.0;
                group.removedOnCompletion = false;
                group.fillMode = kCAFillModeForwards;
                button.layer.addAnimation(group, forKey: nil);
            }
        }
    }
    private func getAnimationValues(button:UIButton,angle:Double,index:Double)->(NSArray){
        
        var one = CGPointZero;
        var two = CGPointZero;
        
        if buttonY < 0.4*kPalyhighHeight
        {
            
            print(cosf(Float(index*angle)),coshf(Float(index*angle)),index,angle)
           
            button.x = CGFloat(cosf(Float(index*angle)))*Radius
            button.y = CGFloat(sin(Float(index*angle)))*Radius
            one = CGPointMake(20, 20);
            two = CGPointMake(CGFloat(cosf(Float(index*angle)))*Radius+22, CGFloat(sin(Float(index*angle)))*Radius+22);
        }else{
            button.x = CGFloat(cosf(Float(-index*angle)))*Radius
            button.y = CGFloat(sin(Float(-index*angle)))*Radius+Padding+44
            one = CGPointMake(20, MaxWidth-20);
            two = CGPointMake(CGFloat(cosf(Float(-index*angle)))*Radius+22, CGFloat(sin(Float(-index*angle)))*Radius+22+Padding+44);
        }
        if (self.buttonX != 10) {
            button.x = CGFloat(cosf(Float(M_PI_2+index*angle)))*Radius+Padding+44;
            button.y = CGFloat(sin(Float(M_PI_2+index*angle)))*Radius;
            one = CGPointMake(MaxWidth-20,20);
            two = CGPointMake(CGFloat(cosf(Float(M_PI_2+index*angle)))*Radius+Padding+22+44, CGFloat(sin(Float(M_PI_2+index*angle)))*Radius+22);
            if (self.buttonY >= 0.4*kPalyhighHeight) {
                button.x = CGFloat(cosf(Float(M_PI+index*angle)))*Radius+Padding+44;
                button.y = CGFloat(sin(Float(M_PI+index*angle)))*Radius+Padding+44;
                one = CGPointMake(MaxWidth-20, MaxWidth-20);
                two = CGPointMake(CGFloat(cosf(Float(M_PI+index*angle)))*Radius+Padding+22+44, CGFloat(sin(Float(M_PI+index*angle)))*Radius+22+Padding+44);
            }
        }
        let oneValue = NSValue(CGPoint: one);
        let twoValue = NSValue(CGPoint: two);
        return [oneValue,twoValue];
    }
}
