//
//  Lemonade.swift
//  LemonadeStand
//
//  Created by Timothy Jacobs on 10/19/14.
//  Copyright (c) 2014 Iron Bound Designs. All rights reserved.
//

import Foundation

class Lemonade {
    
    private var lemons: Int
    private var ice: Int
    
    private init(lemons: Int, ice: Int) {
        self.lemons = lemons
        self.ice = ice
    }
    
    class func make(lemons: Int, ice: Int) -> Lemonade? {
        if lemons > 0 || ( lemons <= 0 && ice > 0 ) {
            return Lemonade(lemons: lemons, ice: ice)
        } else {
            return nil
        }
    }
    
    func getPercentLemonade() -> Int {
        let float = Float(lemons) / Float(( lemons + ice ))
        
        return Int(float * 100)
    }
}