//
//  FaceViewController.swift
//  Game
//
//  Created by Joey Nutinsky on 9/14/16.
//  Copyright © 2016 JoeyNutinsky. All rights reserved.
//

import AVFoundation
import UIKit
import Alamofire

class FaceViewController: UIViewController {
    
    @IBOutlet var slider: UISlider!
    //@IBOutlet var pinchRec: UIPinchGestureRecognizer!
    @IBOutlet var yellowBtn: YellowButton!
    //@IBOutlet var dragGesture: UIPanGestureRecognizer!
    @IBOutlet var addButton: AddFace!
    
    

    
    var isDanny = true
    var character = "frank"
    
    var dannyImage = UIImage(named: "danny")
    
    var imageView:FaceImage = FaceImage(imageIcon: UIImage(named: "danny"), location: CGPoint(x: 200, y: 200))
    
    
    var activeImage:UIImage?
    
    var location : CGPoint?
    var lastLocation:CGPoint = CGPoint(x: 0, y: 0)
    
//    var listOfTimes = 0
//    var startTimes = [[81.3,38.7,54.5,33.6,17.0,68.0],[29.2,274.7]]
//    var endTimes = [[83.2,40.6,55.5,35.2,17.9,71.3],[32.1,279.0]]
//    
//    var audioData : [String: [String: Float]]
    
    
    var data : [String: Array<Any>] = [
        "frank": [
            ["start": 81.3, "stop":83.2],
            ["start": 38.7, "stop":40.6]
        ],
        "charlie": [
            ["start": 29.2, "stop":32.1]
        ]
    ]
    
    
    
    var index = 0
    var altIndex = 0
    
    var facesOnScreen:[FaceImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getData();
        
        self.view.addSubview(imageView)
        facesOnScreen.append(imageView)
        activeImage = dannyImage
        
        imageView.image = activeImage
        imageView.lastLocation = imageView.center
        imageView.isUserInteractionEnabled = true
        imageView.isMultipleTouchEnabled = true
        
        location = imageView.center
        
        let clip = data["frank"]![0] as! [String:Double]
        print(clip["start"])
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            //self.performSegue(withIdentifier: "ShowCharlie", sender: self)
            changeFaces()
            isDanny = !isDanny
            //listOfTimes = isDanny ? 0 : 1
            character = isDanny ? "frank" : "charlie"
            
            let tempIndex = index
            index = altIndex
            altIndex = tempIndex
            
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let nextViewController = segue.destination as! ListViewController
        nextViewController.totalFaces = facesOnScreen.count
        nextViewController.isDanny = isDanny
    }

    
    
    
    //Get the NEW DATA!
    func getData(){
        Alamofire.request("http://localhost:3000/charactersAndTimes").responseJSON { response in
            debugPrint(response)
            let json = response.result.value
            self.data = json as! [String:Array<[String:Double]>]
            print(self.data["frank"])
            
        }
    }
    
    func placeImg(_ imgView: UIImageView?, pos: CGPoint) {
        imgView!.center = pos
    }
    
    @IBAction func printCoords(_ sender: AnyObject) {
       playSound()
    }

    @IBAction func buttonPress(_ sender: AnyObject) {
        yellowBtn.endTouch()
        playSound()
    }
    
    var player: AVAudioPlayer?
    var timer : Timer?
    
    func playSound() {
        
        let soundTitle = isDanny ? "frank2" : "charlie"
        let url = Bundle.main.url(forResource: soundTitle, withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            
            //player.currentTime = TimeInterval(startTimes[listOfTimes][index])
            
            let clip = data[character]![index] as! [String:Double]
            
            player.currentTime = TimeInterval(clip["start"]!)
            
            
            player.prepareToPlay()
            player.play()
            timer?.invalidate()
            setTimer(clip: clip)
        } catch let error as NSError {
            print(error.description)
        }
    }
    @IBAction func showList(_ sender: AnyObject) {
        
        self.performSegue(withIdentifier: "showList", sender: self)
        
    }
    
    @IBAction func backToFaces(segue: UIStoryboardSegue) {}
    
    @IBAction func addFace(_ sender: AnyObject) {
        
        addButton.endTouch()
        let imageTitle = isDanny ? "danny" : "charlie"
        
        
        
        let imageViewNew:FaceImage = FaceImage(imageIcon: UIImage(named: imageTitle), location: CGPoint(x: 200, y: 200))
        
        self.view.addSubview(imageViewNew)
        facesOnScreen.append(imageViewNew)
        
        imageViewNew.isUserInteractionEnabled = true
        imageViewNew.isMultipleTouchEnabled = true
    }

    func setTimer(clip: [String: Double])
    {
        //timer = Timer.scheduledTimer(timeInterval: (endTimes[listOfTimes][index]-startTimes[listOfTimes][index]), target: self, selector: #selector(stopSound), userInfo: nil, repeats: false)
        timer = Timer.scheduledTimer(timeInterval: (clip["stop"]!-clip["start"]!), target: self, selector: #selector(stopSound), userInfo: nil, repeats: false)
        
    }
    
    func changeFaces()
    {
        let imageTitle = isDanny ? "charlie" : "danny"
        for face in facesOnScreen {
            face.image = UIImage(named: imageTitle)
        }
        
    }
    
    func stopSound() {
        if(player?.isPlaying == true){
            player?.stop()
            if(index<data[character]!.count-1)
            {
                index+=1
            } else {
                index = 0
            }
        }
    }
}
