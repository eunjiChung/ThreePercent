//
//  GradientView.swift
//  ThreePercent
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 19/05/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    // 1
    @IBInspectable var startColor: UIColor = UIColor.init(red: 251.0/255.0, green: 120.0/255.0, blue: 116.0/255.0, alpha: 1.0)
    @IBInspectable var endColor: UIColor = UIColor.init(red: 245.0/255.0, green: 52.0/255.0, blue: 74.0/255.0, alpha: 1.0)

    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        // 2
        let context = UIGraphicsGetCurrentContext()!
        let colors = [startColor.cgColor, endColor.cgColor]
        
        // 3
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // 4
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        // 5
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)!
        
        // 6
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
    }
    
}
