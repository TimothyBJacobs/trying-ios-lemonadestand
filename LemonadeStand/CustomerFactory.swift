//
//  CustomerFactory.swift
//  LemonadeStand
//
//  Created by Timothy Jacobs on 10/19/14.
//  Copyright (c) 2014 Iron Bound Designs. All rights reserved.
//

import Foundation

class CustomerFactory {
    class func make(numCustomers: Int) -> [Customer] {
        var customers:[Customer] = []
        
        for var i = 0; i < numCustomers; i++ {
            customers.append(Customer.make())
        }
        
        return customers
    }
}