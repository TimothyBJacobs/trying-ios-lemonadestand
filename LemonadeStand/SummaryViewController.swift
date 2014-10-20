//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Timothy Jacobs on 10/19/14.
//  Copyright (c) 2014 Iron Bound Designs. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var customersPaidLabel: UILabel!
    @IBOutlet weak var customersMissedLabel: UILabel!
    @IBOutlet weak var moneyEarnedLabel: UILabel!
        private var store: Store!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store = Store.sharedInstance
        
        loadWeather(store.getLastResult().weather)
        loadCustomersPaid(store.getLastResult().paid)
        loadCustomersMissed(store.getLastResult().skipped)
        loadMoneyEarned(store.getLastResult().earned)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadWeather(weather: Weather) {
        
        switch weather {
            case Weather.Mild:
                weatherImage.image = UIImage(named: "Mild")
                weatherLabel.text = "Mild"
                
            case Weather.Cold:
                weatherImage.image = UIImage(named: "Cold")
                weatherLabel.text = "Cold"
                
            case Weather.Warm:
                weatherImage.image = UIImage(named: "Warm")
                weatherLabel.text = "Warm"
            
            default:
                weatherImage.image = UIImage(named: "Mild")
                weatherLabel.text = "Mild"
        }
    }
    
    private func loadCustomersPaid(num: Int) {
        if num == 1 {
            customersPaidLabel.text = "1 Customer Paid"
        } else {
            customersPaidLabel.text = "\(num) Customers Paid"
        }
    }
    
    private func loadCustomersMissed(num: Int) {
        if num == 1 {
            customersMissedLabel.text = "1 Customer Hated It"
        } else {
            customersMissedLabel.text = "\(num) Customers Hated It"
        }
    }
    
    private func loadMoneyEarned(num: Int) {
        moneyEarnedLabel.text = "$\(num) Earned"
    }
}

