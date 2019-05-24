//
//  FirstViewController.swift
//  random number
//
//  Created by 大江祥太郎 on 2019/01/27.
//  Copyright © 2019年 shotaro. All rights reserved.
//

import UIKit
import AVFoundation
import LTMorphingLabel

class FirstViewController: UIViewController {

    var timer:Timer!
    var audioPlayer:AVAudioPlayer!
    
    private var effectTimer: Timer?
    private var index: Int = 0
    
    
    var titleList = ["HANAMARU","Hanamaru"]
    @IBOutlet weak var titleLabel: LTMorphingLabel!
    
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        effectTimer = Timer.scheduledTimer(timeInterval: 3.0,
                                           target: self,
                                           selector: #selector(updateLabel(timer:)), userInfo: nil,
                                           repeats: true)
        effectTimer?.fire()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        effectTimer?.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @objc func updateLabel(timer: Timer) {
        titleLabel.text = titleList[index]
        
       
        index += 1
        if index >= titleList.count {
            index = 0
        }
        
    }
    @IBAction func goButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toSecond", sender: nil)
        //ボタンを回転
        let rotationAnimation = CABasicAnimation(keyPath:"transform.rotation.z")
        rotationAnimation.toValue = CGFloat(Double.pi / 180) * 180
        rotationAnimation.duration = 0.3
        rotationAnimation.repeatCount = 1
        sender.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
   

}
