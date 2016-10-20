//
//  ListViewController.swift
//  Game
//
//  Created by Joey Nutinsky on 10/3/16.
//  Copyright © 2016 JoeyNutinsky. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet var faceCount: UILabel!
    
    @IBOutlet var displayFace: UIImageView!
    
    var totalFaces:Int = 0
    var isDanny:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        faceCount.text = String(totalFaces)
        // Do any additional setup after loading the view.
        
        let imageName = isDanny ? "danny" : "charlie"
        
        displayFace.image = UIImage(named:imageName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToFaces(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "backToFaces", sender: self)
    }

    @IBAction func takePhoto(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "showCamera", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
