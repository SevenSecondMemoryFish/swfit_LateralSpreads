//
//  DragButton.swift
//  PalyHigh
//
//  Created by wsj on 16/8/8.
//  Copyright © 2016年 wsj. All rights reserved.
//

import UIKit

class DragButton: UIButton {

    var AddView:UIView?;
    var myBlock:((button:DragButton)->())?
    
     init(frame: CGRect,addView:UIView) {
        super.init(frame: frame)
        setImage(UIImage(named: "jiahao"), forState: .Normal);
        layer.cornerRadius = width/2;
        layer.masksToBounds = true;
        let pin = UIPanGestureRecognizer(target: self, action: "pan:");
        addGestureRecognizer(pin);
        addView.addSubview(self)
        AddView = addView;
    }
    
    func pan(pan:UIGestureRecognizer)
    {
        switch(pan.state){
        case .Began:
           
            self.center = pan.locationInView(AddView);
            break;
        case .Changed:
            if self.selected
            {
                myBlock!(button: self);
                return;
            }
            let point = pan.locationInView(AddView!);
            self.center = point;
            break;
        case .Ended:
            
            if (self.center.x<0.5*kPalyhighWidth) {
                
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.x = 10;
                })
            }else{
                
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.x = kPalyhighWidth-10-self.width;
                })
            }
            break;
        default:
            break;
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
