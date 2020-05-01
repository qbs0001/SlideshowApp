//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 0001 QBS on 2020/04/24.
//  Copyright © 2020 qbs0001. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var displayImageNo = 0
    let imageNameArray = ["イチゴ", "メロン", "スイカ", "パイン", "バナナ"]
    
    // タイマー
    var timer: Timer!

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    

    @IBAction func backButtonTap(_ sender: Any) {

        guard self.timer == nil else { return }
        
        if displayImageNo == 0 {
            displayImageNo = 4
            displayImage()
        } else {
            displayImageNo -= 1
            displayImage()
        }
    }
    
    @IBAction func nextButtonTap(_ sender: Any) {
        
        guard self.timer == nil else { return }
        
        if displayImageNo < imageNameArray.count - 1 {
            displayImageNo += 1
            displayImage()
        } else {
            displayImageNo = 0
            displayImage()
        }
    }
    
    @IBAction func switchButtonTap(_ sender: Any) {
        
        if self.timer == nil {
            
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(nextImage(_:)), userInfo: nil, repeats: true)
            
            backButton.isEnabled = false
            nextButton.isEnabled = false
            switchButton.setTitle("停止", for: .normal)
            
        } else {
            
            self.timer.invalidate()
            self.timer = nil
            
            backButton.isEnabled = true
            nextButton.isEnabled = true
            switchButton.setTitle("再生", for: .normal)
            
        }
    }
    
    @objc func nextImage(_ timer: Timer) {
        
        if displayImageNo < imageNameArray.count - 1 {
            displayImageNo += 1
            displayImage()
        } else {
            displayImageNo = 0
            displayImage()
        }
    }
    
    func displayImage() {
        
        let name = imageNameArray[displayImageNo]
        let image = UIImage(named: name)

        imageView.image = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let image = UIImage(named: "イチゴ")
        imageView.image = image
        imageView.isUserInteractionEnabled = true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let nextViewController:nextViewController = segue.destination as! nextViewController
        let name = imageNameArray[displayImageNo]
        
        nextViewController.name = name

    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }


}

