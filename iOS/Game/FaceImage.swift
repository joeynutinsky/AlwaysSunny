//
//  FaceImage.swift
//  Game
//
//  Created by Joey Nutinsky on 9/15/16.
//  Copyright © 2016 JoeyNutinsky. All rights reserved.
//

import UIKit

class FaceImage: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var lastLocation:CGPoint = CGPoint(x: 200, y: 200)
    var lastLocationForZoom:CGPoint = CGPoint(x: 200, y: 200)
    var panRecognizer:UIPanGestureRecognizer?
    var zoomRecognizer:UIPinchGestureRecognizer?
    var rotateRecognizer:UIRotationGestureRecognizer?
    var longPressRecognizer:UILongPressGestureRecognizer?
    
    var initialWidth:CGFloat?
    
    
    init(imageIcon: UIImage?, location:CGPoint) {
        super.init(image: imageIcon)
        //self.isUserInteractionEnabled = true
        
        self.contentMode = .scaleAspectFit
        
        self.panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.detectPan(_:)))
        self.center = lastLocation
        //self.gestureRecognizers = [panRecognizer!]
        
        self.zoomRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(self.zoomHead(_:)))
        self.isMultipleTouchEnabled = true
        
        self.rotateRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(self.rotateHead(_:)))
        
        self.longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.deleteMe(_:)))
        
        self.gestureRecognizers=[panRecognizer!,zoomRecognizer!,rotateRecognizer!,longPressRecognizer!]
        
        
        self.zoomRecognizer?.cancelsTouchesInView = true
        self.zoomRecognizer?.delaysTouchesEnded = true
        
        self.rotateRecognizer?.cancelsTouchesInView = true
        self.rotateRecognizer?.delaysTouchesEnded = true
        
        initialWidth = self.image?.size.width
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func detectPan(_ recognizer:UIPanGestureRecognizer) {
        let translation  = recognizer.translation(in: self.superview!)
        lastLocationForZoom = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
        
        //self.center = lastLocation
        
        self.center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
        
    }
    func gestureRecognizer(_: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
        return true
    }
    
    func zoomHead(_ recognizer:UIPinchGestureRecognizer) {
        
        let state = recognizer.state
        if(state==UIGestureRecognizerState.began || state == UIGestureRecognizerState.changed)
        {
            let scale = recognizer.scale
            let imageWidth = scale * (self.image?.size.width)!
            let imageHeight = scale * (self.image?.size.height)!
        
            self.frame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
            self.center = lastLocation
        }
    }
    
    func rotateHead(_ recognizer:UIRotationGestureRecognizer) {
        
        self.transform = self.transform.rotated(by: recognizer.rotation)
        recognizer.rotation = 0
        
    }
    
    var timer:Timer?
    var scale = CGFloat(0.5)
    func deleteMe(_ recognizer:UILongPressGestureRecognizer) {
        //let listView = self.superview as! FaceViewController
        //listView.removeImageFromArray(toRemove: self)
        self.removeFromSuperview()
        
    }
    
    func shrinkImage(_ timerPas:Timer)
    {

        
        let imageWidth = scale * (self.image?.size.width)!
        let imageHeight = scale * (self.image?.size.height)!
        
        self.frame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        self.center = lastLocation

        if(imageWidth<(initialWidth!*0.1))
        {
            timerPas.invalidate()
            self.removeFromSuperview()
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Promote the touched view
        self.superview?.bringSubview(toFront: self)
        
        // Remember original location
        lastLocation = self.center
        
        //Zoom in a wee bit
        /*let imageWidth = 1.1 * (self.image?.size.width)!
        let imageHeight = 1.1 * (self.image?.size.height)!
        
        self.frame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        self.center = lastLocation*/

    }
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let imageWidth = 0.9 * (self.image?.size.width)!
//        let imageHeight = 0.9 * (self.image?.size.height)!
//        
//        self.frame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
//        self.center = lastLocation
//
//    }
    
    

}
