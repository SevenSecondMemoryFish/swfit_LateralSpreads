//
//  HomeModel.swift
//  PalyHigh
//
//  Created by cll12_12 on 16/8/2.
//  Copyright © 2016年 wsj. All rights reserved.
//

import UIKit

class HomeModel: NSObject {
    
    var createdAt: String?
    var desc: String?
    var imageUrl: String?
    var objectId: String?
    var priceNow: String?
    var sellCount: String?
    var title: String?
    var updateAt: String?
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
    
    override func valueForUndefinedKey(key: String) -> AnyObject? {
        return nil
    }
}

