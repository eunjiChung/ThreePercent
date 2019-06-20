//
//  Matching2ViewController.swift
//  ThreePercent
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 19/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import Lottie
import Alamofire
import AlamofireImage

class MatchingViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    // MARK : - Outlets
    @IBOutlet weak var tableView: UITableView!
    let sendLoveList: [String]? = nil
    let randomList: [String]?   = nil
    
    
    // MAKR : - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")

        // Do any additional setup after loading the view.
        registerCell()
        requestMatchingList()
    }
    
    // MARK : - Layout
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get { return .lightContent }
    }
    
    // MARK : - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: LottieTableViewCell.identifier, for: indexPath) as! LottieTableViewCell
            cell.batteryLeftLabel.text = "\(Int(CURRENT_BATTERY_LEVEL*100))%"
            addLottieAnimation(cell)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TabBarTableViewCell.identifier, for: indexPath)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: TabViewTableViewCell.identifier, for: indexPath)
            return cell
        }
    }
    
    // MARK : - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return CGFloat(127.0)
        case 1:
            return CGFloat(49.0)
        default:
            return CGFloat(UIScreen.main.bounds.height - 127.0 - 49.0)
        }
    }
    
    
    
    // MARK : - Register Nib
    func registerCell() {
        
        print("registerCell")
        
        tableView.register(UINib.init(nibName: LottieTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: LottieTableViewCell.identifier)
        tableView.register(UINib.init(nibName: TabBarTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TabBarTableViewCell.identifier)
        tableView.register(UINib.init(nibName: TabViewTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TabViewTableViewCell.identifier)
    }
    
    // MARK : - Private Method
    func addLottieAnimation(_ cell: UIView) {
        let animationView = AnimationView(name: "3")
        animationView.loopMode = .loop
        animationView.frame = cell.frame
        cell.addSubview(animationView)
        animationView.play()
    }
    
    func requestMatchingList() {
    
        Alamofire.request(requestURL, method: .get
            ).responseJSON { (response) in
                guard response.result.isSuccess else {
                    return
                }
                
                guard let data = response.result.value as? [String: Any] else {
                    return
                }
                
                debugPrint(data)
        }
    }
}
