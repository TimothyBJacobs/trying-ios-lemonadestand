//
//  Customer.swift
//  LemonadeStand
//
//  Created by Timothy Jacobs on 10/19/14.
//  Copyright (c) 2014 Iron Bound Designs. All rights reserved.
//

import Foundation

class Customer {
    
    private var percent: Int
    
    private init(percent: Int) {
        self.percent = percent
    }
    
    class func make() -> Customer {
        return Customer(percent: Int(arc4random_uniform(100)) + 1)
    }
    
    class func make(percent: Int) -> Customer? {
        if percent >= 0 && percent <= 100 {
            return Customer(percent: percent)
        } else {
            return nil
        }
    }
    
    func likesLemonade(lemonade: Lemonade) -> Bool {
        return abs( percent - lemonade.getPercentLemonade() ) < Store.kPercentDiff()
    }
}