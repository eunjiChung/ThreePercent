//
//  ReadyViewController.swift
//  ThreePercent
//
//  Created by 一ノ瀬琉聖 on 18/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class ReadyViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get { return .lightContent }
    }
    
    var BatteryLevel : Float{
        return UIDevice.current.batteryLevel
    }
    
    @IBOutlet var titleMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        let BatteryRemnant = Int(BatteryLevel * 100 - 3);
        
        let data: Data = "<font color=white size=40 face=AppleSDGothicNeo-UltraLight>옷깃에 스치려면<br><font color=red face=AppleSDGothicNeo-Bold>\(BatteryRemnant)%</font><br>남았어요</font>".data(using: .unicode)!
        let str = try! NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        titleMessage.attributedText = str;
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
