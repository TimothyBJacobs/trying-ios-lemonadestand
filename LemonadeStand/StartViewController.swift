//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Timothy Jacobs on 10/19/14.
//  Copyright (c) 2014 Iron Bound Designs. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    // inventory
    @IBOutlet weak var storeMoneyLabel: UILabel!
    @IBOutlet weak var storeNumLemonsLabel: UILabel!
    @IBOutlet weak var storeNumIceLabel: UILabel!
    
    // step 1, purchase supplies
    @IBOutlet weak var buyNumLemonsLabel: UILabel!
    @IBOutlet weak var buyNumIceLabel: UILabel!
    
    // step 2, mix
    @IBOutlet weak var mixNumLemonsLabel: UILabel!
    @IBOutlet weak var mixNumIceLabel: UILabel!
    
    // game specific data
    private var store: Store!
    
    private var currentMixLemons = 0
    private var currentMixIce = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store = Store.sharedInstance
        
        setMoney(store.getMoney())
        setLemons(store.getLemons())
        setIce(store.getIce())
    }
    
    override func viewDidAppear(animated: Bool) {
        if !store.canKeepPlaying() {
            showMessage(header: "Game Over", message: "You are out of money")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // step 1 controls
    @IBAction func decBuyLemons(sender: AnyObject) {
        if buyNumLemonsLabel.text?.toInt() <= 0 {
            showMessage(message: "You can't buy less than 0 lemons")
            
            return
        }
        
        if store.getLemons() == 0 && currentMixLemons > 0 {
            showMessage(message: "You need those lemons!")
            
            return
        }
        
        if let current = buyNumLemonsLabel.text?.toInt()? {
            buyNumLemonsLabel.text = "\(current - 1)"
        } else {
            buyNumLemonsLabel.text = "1"
        }
        
        store.modMoney(+2)
        store.modLemons(-1)
        
        setMoney(store.getMoney())
        setLemons(store.getLemons())
    }
    
    @IBAction func incBuyLemons(sender: UIButton) {
        if 2 > store.getMoney() {
            showMessage(message: "You don't have enough money")
            
            return
        }
        
        if let current = buyNumLemonsLabel.text?.toInt()? {
            buyNumLemonsLabel.text = "\(current + 1)"
        } else {
            buyNumLemonsLabel.text = "1"
        }
        
        store.modMoney(-2)
        store.modLemons(+1)
        
        setMoney(store.getMoney())
        setLemons(store.getLemons())
    }
    
    @IBAction func decBuyIce(sender: UIButton) {
        if buyNumIceLabel.text?.toInt() <= 0 {
            showMessage(message: "You can't buy less than 0 ice cubes")
            
            return
        }
        
        if store.getIce() == 0 && currentMixIce > 0 {
            showMessage(message: "You need those ice cubes!")
            
            return
        }
        
        if let current = buyNumIceLabel.text?.toInt()? {
            buyNumIceLabel.text = "\(current - 1)"
        } else {
            buyNumIceLabel.text = "1"
        }
        
        store.modMoney(+1)
        store.modIce(-1)
        
        setMoney(store.getMoney())
        setIce(store.getIce())
    }
    
    @IBAction func incBuyIce(sender: UIButton) {
        if 1 > store.getMoney() {
            showMessage(message: "You don't have enough money")
            
            return
        }
        
        if let current = buyNumIceLabel.text?.toInt()? {
            buyNumIceLabel.text = "\(current + 1)"
        } else {
            buyNumIceLabel.text = "1"
        }
        
        store.modMoney(-1)
        store.modIce(+1)
        
        setMoney(store.getMoney())
        setIce(store.getIce())
    }

    // step 2 controls
    @IBAction func decMixLemons(sender: UIButton) {
        if mixNumLemonsLabel.text?.toInt() <= 0 {
            showMessage(message: "You can't mix with less than 0 lemons")
            
            return
        }
        
        if let current = mixNumLemonsLabel.text?.toInt()? {
            mixNumLemonsLabel.text = "\(current - 1)"
        } else {
            mixNumLemonsLabel.text = "1"
        }
        
        store.modLemons(+1)
        setLemons(store.getLemons())
        currentMixLemons -= 1
    }
    
    @IBAction func incMixLemons(sender: UIButton) {
        if store.getLemons() < 1 {
            showMessage( message: "You don't have enough lemons")
            
            return
        }
        
        if let current = mixNumLemonsLabel.text?.toInt()? {
            mixNumLemonsLabel.text = "\(current + 1)"
        } else {
            mixNumLemonsLabel.text = "1"
        }
        
        store.modLemons(-1)
        setLemons(store.getLemons())
        currentMixLemons += 1
    }
    
    @IBAction func decMixIce(sender: UIButton) {
        if mixNumIceLabel.text?.toInt() <= 0 {
            showMessage(message: "You can't mix with less than 0 ice cubes")
            
            return
        }
        
        if let current = mixNumIceLabel.text?.toInt()? {
            mixNumIceLabel.text = "\(current - 1)"
        } else {
            mixNumIceLabel.text = "1"
        }
        
        store.modIce(+1)
        setIce(store.getIce())
        currentMixIce -= 1
    }
    
    @IBAction func incMixIce(sender: UIButton) {
        if store.getIce() < 1 {
            showMessage( message: "You don't have enough ice cubes")
            
            return
        }
        
        if let current = mixNumIceLabel.text?.toInt()? {
            mixNumIceLabel.text = "\(current + 1)"
        } else {
            mixNumIceLabel.text = "1"
        }
        
        store.modIce(-1)
        setIce(store.getIce())
        currentMixIce += 1
    }
    
    // start
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if currentMixIce == 0 && currentMixLemons == 0 {
            
            showMessage(message: "You need at least 1 lemon or 1 ice cube")
            
            return false
        } else {
            return true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        store.playDay(currentMixLemons, numIce: currentMixIce)
    }
    
    // helpers
    private func setMoney(money: Int) {
        storeMoneyLabel.text = "$\(money)"
        storeMoneyLabel.sizeToFit()
    }
    
    private func setLemons(lemons: Int) {
        if lemons == 1 {
            storeNumLemonsLabel.text = "1 lemon"
        } else {
            storeNumLemonsLabel.text = "\(lemons) lemons"
        }
        
        storeNumLemonsLabel.sizeToFit()
    }
    
    private func setIce(ice: Int) {
        if ice == 1 {
            storeNumIceLabel.text = "1 Ice Cube"
        } else {
            storeNumIceLabel.text = "\(ice) Ice Cubes"
        }
        
        storeNumIceLabel.sizeToFit()
    }
    
    
    private func showMessage(header: String = "Warning", message: String ) {
        
        var alert = UIAlertController(title: header, message: message,
            preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}

