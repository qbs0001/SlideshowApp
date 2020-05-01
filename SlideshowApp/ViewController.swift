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
    
    var switchFlag: Bool = false
    
    // タイマー
    var timer: Timer!

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    

    @IBAction func backButtonTap(_ sender: Any) {

        guard self.timer == nil else { return }
        
        // 最初の画像の場合、最後の画像を表示
        if displayImageNo == 0 {
            displayImageNo = 4
            displayImage()
        // ひとつ前の画像を表示
        } else {
            displayImageNo -= 1
            displayImage()
        }
    }
    
    @IBAction func nextButtonTap(_ sender: Any) {
        
        guard self.timer == nil else { return }

        // 最後の画像でない場合、ひとつ後の画像を表示
        if displayImageNo < imageNameArray.count - 1 {
            displayImageNo += 1
            displayImage()
        // 最初の画像を表示
        } else {
            displayImageNo = 0
            displayImage()
        }
    }
    
    @IBAction func switchButtonTap(_ sender: Any) {
        
        // 再生時
        if self.timer == nil {
            
            // ２秒間隔のタイマーを実行
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(nextImage(_:)), userInfo: nil, repeats: true)
            
            // 進むと戻るボタンを非表示
            backButton.isEnabled = false
            nextButton.isEnabled = false
            
            // 停止にタイトルを変更
            switchButton.setTitle("停止", for: .normal)
        // 停止時
        } else {
            
            // タイマーを破棄
            self.timer.invalidate()
            self.timer = nil
            
            // 進むと戻るボタンを表示
            backButton.isEnabled = true
            nextButton.isEnabled = true
            
            // 再生にタイトルを変更
            switchButton.setTitle("再生", for: .normal)
            
        }
    }
    
    @objc func nextImage(_ timer: Timer) {
        
        // 最後の画像でない場合、ひとつ後の画像を表示
        if displayImageNo < imageNameArray.count - 1 {
            displayImageNo += 1
            displayImage()
        // 最初の画像を表示
        } else {
            displayImageNo = 0
            displayImage()
        }
    }
    
    func displayImage() {
        
        let name = imageNameArray[displayImageNo]
        let image = UIImage(named: name)

        // 配列から画像名を取得し、対象の画像を表示
        imageView.image = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // イチゴを初期表示
        let image = UIImage(named: "イチゴ")
        imageView.image = image
        
        // 画像をタップ可能とする
        imageView.isUserInteractionEnabled = true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let nextViewController:nextViewController = segue.destination as! nextViewController
        let name = imageNameArray[displayImageNo]
        
        // 拡大表示する画像名を渡す
        nextViewController.name = name
        
        // タイマーが起動している場合は、破棄する
        if self.timer != nil {
            self.timer.invalidate()
            self.timer = nil
            // 破棄フラグを設定する
            self.switchFlag = true
        }

    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        
        // タイマーを破棄している場合は、タイマーを再開する
        if self.switchFlag == true {
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(nextImage(_:)), userInfo: nil, repeats: true)
            // 破棄フラグを初期化する
            self.switchFlag = false
            
        }
        
    }


}

