//
//  Store.swift
//  LemonadeStand
//
//  Created by Timothy Jacobs on 10/19/14.
//  Copyright (c) 2014 Iron Bound Designs. All rights reserved.
//

import Foundation

class Store {
    
    final class func kPercentDiff() -> Int { return 10 }
    
    private final let kBaseCustomers = 7
    
    private var money: Int
    private var lemons: Int
    private var ice: Int
    
    private var lastResult: (paid: Int, skipped: Int,
                             earned: Int, weather: Weather)?
    
    class var sharedInstance: Store {
        struct Static {
            static var instance: Store?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = Store(money: 10, lemons: 1, ice: 1)
        }
        
        return Static.instance!
    }
    
    
    init(money: Int, lemons: Int, ice: Int) {
        self.money = money
        self.lemons = lemons
        self.ice = ice
    }
    
    func canKeepPlaying() -> Bool {
        if lemons > 0 || ice > 0 {
            return true
        }
        
        if lemons == 0 && ice == 0 && money > 0 {
            return true
        }
        
        return false
    }
    
    func playDay(numLemons: Int, numIce: Int) {
        // play a day of lemonade, updates money, stock should be updated prior
        var lemonade = Lemonade.make(numLemons, ice: numIce)!
        var weather = getWeather()
        
        var paid = 0
        var skipped = 0
        let customers = CustomerFactory.make(getNumCustomers(weather))
        
        for customer in customers {
            if customer.likesLemonade(lemonade) {
                paid += 1
            } else {
                skipped += 1
            }
        }
        
        modMoney(+paid)
        
        lastResult = (paid, skipped, paid, weather)
    }
    
    private func getNumCustomers(weather: Weather) -> Int {
        return kBaseCustomers + weather.rawValue
    }
    
    private func getWeather() -> Weather {
        
        let rand = Int(arc4random_uniform(UInt32(3)))
        
        switch rand {
        case 0:
            return Weather.Cold
        case 1:
            return Weather.Mild
        case 2:
            return Weather.Warm
        default:
            return Weather.Mild
        }
    }

    
    // getters and setters
    
    func getLastResult() -> (paid: Int, skipped: Int,
                             earned: Int, weather: Weather)!
    {
        return lastResult
    }
    
    func getMoney() -> Int {
        return money
    }
    
    func modMoney(amount: Int) {
        money += amount
    }
    
    func getLemons() -> Int {
        return lemons
    }
    
    func modLemons(amount: Int) {
        lemons += amount
    }
    
    func getIce() -> Int {
        return ice
    }
    
    func modIce(amount: Int) {
        ice += amount
    }
}