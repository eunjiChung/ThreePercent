//
//  MatchingViewController.swift
//  ThreePercent
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 18/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class MatchingViewController: UIViewController {
    

    // MARK : - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        swipeHandler()
    }
    
    // MARK : - Layout
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get { return .lightContent }
    }
    
    
    // MARK : - IBAction
    func swipeHandler() {
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        
        if (sender.direction == .down) {
            print("Swipe down")
            tabBarController?.selectedIndex = 0
        }
        
    }
    
    

}
