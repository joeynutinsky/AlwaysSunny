//
//  StatsButton.swift
//  Game
//
//  Created by Joey Nutinsky on 10/14/16.
//  Copyright © 2016 JoeyNutinsky. All rights reserved.
//

import UIKit

class StatsButton: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        ButtonKit.drawStats(frame: self.bounds)
    }

}
