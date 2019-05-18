//
//  BaseViewController.swift
//  ThreePercent
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 18/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit


public let CURRENT_BATTERY_LEVEL              =    UIDevice.current.batteryLevel

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setBattery()
    }
    
    // MARK : - Battery Check
    func setBattery() {
        UIDevice.current.isBatteryMonitoringEnabled = true
    }

}
