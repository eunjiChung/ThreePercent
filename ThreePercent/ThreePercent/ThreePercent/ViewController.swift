//
//  ViewController.swift
//  ThreePercent
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 18/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        return cell
    }
    
    var getBatteryLevel : Float{
        return UIDevice.current.batteryLevel
    }

    
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UIDevice.current.isBatteryMonitoringEnabled = true
        button.setTitle("\(getBatteryLevel * 100)%", for: .normal)
        
    }
    
}

