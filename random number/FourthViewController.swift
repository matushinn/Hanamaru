//
//  FourthViewController.swift
//  random number
//
//  Created by 大江祥太郎 on 2019/01/28.
//  Copyright © 2019年 shotaro. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleDetailLabel: UILabel!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    @IBOutlet weak var fifthButton: UIButton!
    @IBOutlet weak var sixthButton: UIButton!
    
    //ゲーム形式区分け
    var gameFormat:Int = 0
    var level = 0
    
    var modeSecond = 0.0
    var modeQuestionsNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch gameFormat {
        case 1:
            titleLabel.text = "制限時間"
            titleDetailLabel.text = "〜限られた時間で多くの問題を解け〜"
            
            firstButton.setTitle("30s", for: .normal)
            secondButton.setTitle("60s", for: .normal)
            thirdButton.setTitle("90s", for: .normal)
            fourthButton.setTitle("120s", for: .normal)
            fifthButton.setTitle("150s", for: .normal)
            sixthButton.setTitle("180s", for: .normal)
            
        case 2:
            titleLabel.text = "制限問題"
            titleDetailLabel.text = "〜限られた問題数でハイタイムを目指せ〜"
            
            firstButton.setTitle("10問", for: .normal)
            secondButton.setTitle("20問", for: .normal)
            thirdButton.setTitle("30問", for: .normal)
            fourthButton.setTitle("50問", for: .normal)
            fifthButton.setTitle("75問", for: .normal)
            sixthButton.setTitle("100問", for: .normal)
            
            
        default:
            break
        }
    }
    
    @IBAction func modeButton(_ sender: UIButton) {
        //ボタンを回転
        let rotationAnimation = CABasicAnimation(keyPath:"transform.rotation.z")
        rotationAnimation.toValue = CGFloat(Double.pi / 180) * 180
        rotationAnimation.duration = 0.3
        rotationAnimation.repeatCount = 1
        sender.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
        //gameformatの区別
        if gameFormat == 1{
            switch sender.tag {
            case 0:
                modeSecond = 30
            case 1:
                modeSecond = 60
            case 2:
                modeSecond = 90
            case 3:
                modeSecond = 120
            case 4:
                modeSecond = 150
            case 5:
                modeSecond = 180
            default:
                break
            }
        }else{
            //制限問題の場合
            switch sender.tag {
            case 0:
                modeQuestionsNum = 10
            case 1:
                modeQuestionsNum = 20
            case 2:
                modeQuestionsNum = 30
            case 3:
                modeQuestionsNum = 50
            case 4:
                modeQuestionsNum = 75
            case 5:
                modeQuestionsNum = 100
                
            default:
                break
            }
            
        }
        self.performSegue(withIdentifier: "toFourth", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFourth"{
            let questionVC = segue.destination as! ViewController
            //値渡し
            questionVC.level = level
            questionVC.modeSecond = modeSecond
            questionVC.gameFormat = gameFormat
            questionVC.modeQuestionsNum = modeQuestionsNum
        }
    }

}
