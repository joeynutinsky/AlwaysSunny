//
//  YellowButton.swift
//  Game
//
//  Created by Joey Nutinsky on 9/15/16.
//  Copyright © 2016 JoeyNutinsky. All rights reserved.
//

import UIKit

class YellowButton: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var isPressed = false
    
    override func draw(_ rect: CGRect) {
        ButtonKit.drawButton(frame: self.bounds, pressed: isPressed)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isPressed = true
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        endTouch()
    }
    
    func endTouch() {
        isPressed = false
        self.setNeedsDisplay()
    }
    

}
