//
//  AddFace.swift
//  Game
//
//  Created by Joey Nutinsky on 9/30/16.
//  Copyright © 2016 JoeyNutinsky. All rights reserved.
//

import UIKit

class AddFace: UIView {

    var isPressed = false
    
    override func draw(_ rect: CGRect) {
        ButtonKit.drawCanvas1(frame: self.bounds, pressed: isPressed)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isPressed = true
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        endTouch()
    }
    
    public func endTouch() {
        isPressed = false
        print("ended")
        self.setNeedsDisplay()
    }
}
