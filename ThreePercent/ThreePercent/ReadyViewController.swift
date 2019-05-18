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
    @IBOutlet var batteryNumberic: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let BatteryRemnant = BatteryLevel * 100 - 3;
        
        titleMessage.text = "옷깃에 스치려면\n\n남았어요...";
        batteryNumberic.text = "\n\(BatteryRemnant)%"
        // Do any additional setup after loading the view.
        swipeHandler()
    }
    
    
    func swipeHandler() {
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        
        if (sender.direction == .up) {
            print("Swipe up")
            tabBarController?.selectedIndex = 1
        }
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
