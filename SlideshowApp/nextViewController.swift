//
//  nextViewController.swift
//  SlideshowApp
//
//  Created by 0001 QBS on 2020/04/24.
//  Copyright © 2020 qbs0001. All rights reserved.
//

import UIKit

class nextViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    // 受け取るためのプロパティ（変数）を宣言しておく
    var name:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 受け渡された画像を表示する
        let image = UIImage(named: name)
        imageView.image = image
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
