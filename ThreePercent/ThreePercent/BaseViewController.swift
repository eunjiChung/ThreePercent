//
//  BaseViewController.swift
//  ThreePercent
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 18/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

public let CURRENT_BATTERY_LEVEL              =    UIDevice.current.batteryLevel
public let requestURL                         =    "https://df41b5scg5.execute-api.ap-northeast-2.amazonaws.com/dev/users"

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setBattery()
        
        NotificationCenter.default.addObserver(self, selector: #selector(batteryStateDidChange), name: UIDevice.batteryStateDidChangeNotification, object: nil)
    }
    
    // MARK : - Battery Check
    var batteryState: UIDevice.BatteryState {
        return UIDevice.current.batteryState
    }
    
    func setBattery() {
        UIDevice.current.isBatteryMonitoringEnabled = true
    }
    
    @objc func batteryStateDidChange(_ notification: Notification) {
        switch batteryState {
        case .unplugged, .unknown:
            print("not charging")
        case .charging, .full:
            print("charging or full")
        }
    }

}
