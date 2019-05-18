//
//  ReadyViewController.swift
//  ThreePercent
//
//  Created by 一ノ瀬琉聖 on 18/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class ReadyViewController: BaseViewController {
    
    // MARK : - IBOutlet
    @IBOutlet var titleMessage: UILabel!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var chargingImageView: UIImageView!
    
    
    // MARK : - Alc Of Constraints
    @IBOutlet weak var alcHeightOfGradientView: NSLayoutConstraint!
    
    let mentArray = [["3% 3% 3% 3%","3% 3% 3% 3%"],["충전기 없이","기다려요"],["당신과 나의 거리","조금 있다 봐요"],["적은 배터리","하나의 공통점"],["우리","기다려봐요"],["인연 만나려면","근데 어차피 안돼"],["우리","기다려봐요"]]
    
    // MARK : - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        swipeHandler()
        setConer()
        
        // Battery Setting
        batteryTitle()
        setBatteryHeight()
        checkBatteryCharging()
    }
    

    // MARK : - Swipe Handler
    func swipeHandler() {
        if Int(CURRENT_BATTERY_LEVEL * 100) <= 20 {
            let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
            upSwipe.direction = .up
            view.addGestureRecognizer(upSwipe)
        }
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        
        if (sender.direction == .up) {
            tabBarController?.selectedIndex = 1
        }
    }
    
    // MARK : - Layout Control
    func setConer() {
        gradientView.layer.cornerRadius = 10.0
        gradientView.layer.masksToBounds = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get { return .lightContent }
    }
    
    
    // MARK : - Battery Check
    func batteryTitle() {
        
        let BatteryRemnant = Int(CURRENT_BATTERY_LEVEL * 100 - 3);
        
        let mentString = mentArray.randomElement()
        let firstString = mentString![0]
        let SecondString = mentString![1]
        
        let data: Data = "<font color=white size=40 face=AppleSDGothicNeo-UltraLight>\(firstString)<br><font color=red face=AppleSDGothicNeo-Bold>\(BatteryRemnant)%</font><br>\(SecondString)</font>".data(using: .unicode)!
        let str = try! NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        titleMessage.attributedText = str;
    }
    
    func setBatteryHeight() {
        let newHeight = 361.0 * CURRENT_BATTERY_LEVEL
        alcHeightOfGradientView.constant = CGFloat(newHeight)
    }
    
    func checkBatteryCharging() {
        
        if UIDevice.current.batteryState.rawValue == 2 {
            chargingImageView.isHidden = false
        } else {
            chargingImageView.isHidden = true
        }
    }


}
