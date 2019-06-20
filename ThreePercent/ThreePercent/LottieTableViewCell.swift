//
//  LottieTableViewCell.swift
//  ThreePercent
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 19/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class LottieTableViewCell: UITableViewCell {
    
    static let identifier = "LottieTableViewCell"

    @IBOutlet weak var alcLeadingOfBatteryLeftLabel: NSLayoutConstraint!
    @IBOutlet weak var alcTopOfBatteryLeftLabel: NSLayoutConstraint!
    @IBOutlet weak var batteryLeftLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        alcLeadingOfBatteryLeftLabel.constant = 130
        alcTopOfBatteryLeftLabel.constant = 42
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
