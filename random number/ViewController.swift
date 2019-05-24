//
//  ViewController.swift
//  random number
//
//  Created by 大江祥太郎 on 2018/11/29.
//  Copyright © 2018年 shotaro. All rights reserved.
//

import UIKit
import LTMorphingLabel
import AVFoundation


class ViewController: UIViewController {
  
    @IBOutlet weak var leftLabel: LTMorphingLabel!
    @IBOutlet weak var rightLabel: LTMorphingLabel!
    
    @IBOutlet weak var calcLabel: LTMorphingLabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var questionNumLabel: UILabel!
    
    
    @IBOutlet weak var maruImageView: UIImageView!
    @IBOutlet weak var batsuImageView: UIImageView!
    @IBOutlet var mode: [UIButton]!
    
   
   
    var leftNumber :Int=0
    var rightNumber :Int=0
    var result:Int = 0
    
    var calculation:Int = 0
    var index:Int = 0
    
     var calc:[String] = ["+","-","×","❓"]
    //❓を出すindex
    var calcIndex:Int = 0
    
    //timer
    var timer:Timer!
    var count:Double = 0.0
    
    
    
    var modeQuestionsNum = 0
    var modeSecond : String!
    var level:String!
    var second = 0.0
    //問題数
    var questionNum:Int = 1
    //正解数
    var correctAnsNum:Int = 0
    
   
    //乱数
    func arc4random(lower: UInt32, upper: UInt32) -> UInt32 {
        guard upper >= lower else {
            return 0
        }
        
        return arc4random_uniform(upper - lower) + lower
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        //問題表示
        updateLabelQuestion()
        
        rightLabel.morphingEffect = .anvil
        leftLabel.morphingEffect = .anvil
        calcLabel.morphingEffect = .anvil
        
        
        
        switch modeSecond {
        case "30s":
            second = 30.0
            count = 30.0
            timerLabel.text = "30.0"
        case "60s":
            second = 60.0
            count = 60.0
            timerLabel.text = "60.0"
        case "90s":
            
            second = 90.0
            count = 90.0
            timerLabel.text = "90.0"
        case "120s":
            second = 120.0
            count = 120
            timerLabel.text = "120.0"
        case "150s":
            second = 150.0
            count = 150.0
            timerLabel.text = "150.0"
        case "180s":
            second = 180.0
            count = 180
            timerLabel.text = "180.0"
            
        default:
            break
        }
        
        startTimer()
        
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
    }
    
    //    timer
    @objc func update(){
        
        
            count = count - 0.1
            
            if count < 0{
                timer.invalidate()
                self.performSegue(withIdentifier: "toResult", sender: nil)
            }
       
        timerLabel.text = String(format: "%.1f", count)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResult"{
            let resultVC = segue.destination as! ResultViewController
            
            resultVC.level = level
            resultVC.modeSecond = second
            resultVC.modeQuestionsNum = modeQuestionsNum
            
            resultVC.count = count
            resultVC.correctAnsNum = correctAnsNum
        }
    }
    func randomNum(){
        //1~9までの数字
        
        //レベル分け
        switch level {
        case "Beginner":
            //初級
            leftNumber=Int(arc4random(lower: 0, upper: 9))+1
            rightNumber=Int(arc4random(lower: 0, upper: 9))+1
            calculation = Int(arc4random_uniform(3))
           
        case "Intermediate":
            //中級
            leftNumber=Int(arc4random(lower: 10, upper: 100))
            rightNumber=Int(arc4random(lower: 0, upper: 100))
            calculation = Int(arc4random_uniform(3))
            
        case "Advanced":
            //上級
            leftNumber=Int(arc4random(lower: 10, upper: 100))
            rightNumber=Int(arc4random(lower: 10, upper: 99))+1
            calculation = 3
            
        default:
            break
        }
    }
    //問題のアップデート
    func updateLabelQuestion(){
        
        randomNum()
        if calc[calculation] == "+"{
            calcLabel.textColor = UIColor.blue
        }
        if calc[calculation] == "-"{
            calcLabel.textColor = UIColor.green
            if leftNumber < rightNumber{
                randomNum()
            }
        }
        if calc[calculation] == "×"{
            calcLabel.textColor = UIColor.red
        }
        
        leftLabel.text = String(leftNumber)
        rightLabel.text = String(rightNumber)
        calcLabel.text = calc[calculation]
        
        
        questionNumLabel.text = String(questionNum)
        
        calcIndex =  Int(arc4random(lower: 0, upper: 2))
        switch calcLabel.text {
        case "+":
            result = leftNumber + rightNumber
        case "-":
            result = leftNumber - rightNumber
            if result < 0{
                randomNum()
            }
        case "×":
            result = leftNumber * rightNumber
        case "❓":
            if calcIndex == 0{
                result = leftNumber + rightNumber
            }
            if calcIndex == 1{
                result = leftNumber - rightNumber
                if result < 0{
                    randomNum()
                }
            }
            if calcIndex == 2{
                result = leftNumber * rightNumber
            }
        default:
            break
        }
        
        //答えを表示するボタンのタグをランダムで設定
        index = Int(arc4random(lower: 0, upper: 24))
    
        button(UIButton())
    }
    
    func button(_ sender:Any){
        switch level {
        case "Beginner":
            for i in 0...24{
                mode[i].setTitle( String(arc4random(lower: 0, upper: 100)), for: .normal)
            }
            
        case "Intermediate"," Advanced":
            for i in 0...24{
                mode[i].setTitle( String(arc4random(lower: 0, upper: 1000)), for: .normal)
            }
          
        default:
            break
        }
        
        //index番目のタグのボタンを正解にする
        mode[index].setTitle(String(result), for: .normal)
        
    }
    //バイブ
    func vibrate() {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    @IBAction func tappedModeButton(_ sender: UIButton) {
    
        //ボタンを回転
        let rotationAnimation = CABasicAnimation(keyPath:"transform.rotation.z")
        rotationAnimation.toValue = CGFloat(Double.pi / 180) * 180
        rotationAnimation.duration = 0.3
        rotationAnimation.repeatCount = 1
        sender.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
        //正解ボタンを押した時
        if sender.currentTitle == String(result){
            correctAnsNum += 1
            
            //正解
            vibrate()
            //正解音
            AudioServicesPlayAlertSound(1025)
            
            //正解アニメーション
            UIView.animate(withDuration: 0.7, animations: {
                self.maruImageView.alpha = 1.0
            }, completion: { finished in
                self.maruImageView.alpha = 0.0
            })
            
            
            questionNum += 1
            
            
            updateLabelQuestion()
            print("success")
            
        }else{
            //不正解
            vibrate()
            //不正解音
            AudioServicesPlayAlertSound(1006)
            //audioPlayer.pause()
            
            UIView.animate(withDuration: 0.7, animations: {
                self.batsuImageView.alpha = 1.0
            }, completion: { finished in
                self.batsuImageView.alpha = 0.0
            })
            
        }
        
    }
    @IBAction func back(_ sender: Any) {
       
    }
    
    
    
    
}


