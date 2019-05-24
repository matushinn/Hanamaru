//
//  ResultViewController.swift
//  random number
//
//  Created by 大江祥太郎 on 2019/01/27.
//  Copyright © 2019年 shotaro. All rights reserved.
//

import UIKit
import LTMorphingLabel
import AVFoundation

class ResultViewController: UIViewController {

    @IBOutlet weak var levelLabel: LTMorphingLabel!
    @IBOutlet weak var rankLabel: LTMorphingLabel!
    @IBOutlet weak var lastScore: LTMorphingLabel!
    
    var modeSecond = 0.0
    var level:String!
    //正解数
    var correctAnsNum:Int = 0
    var modeQuestionsNum = 0
    
    var gameFormat = 0
    var rankResult:String!
    var rank:Double = 0.0
    
    var levelText = ""
    
    var count:Double = 0.0
    
    var audioPlayer:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //音楽
        do {
            let filePath = Bundle.main.path(forResource: "goal",ofType: "mp3")
            
            let musicPath = URL(fileURLWithPath: filePath!)
            audioPlayer = try AVAudioPlayer(contentsOf: musicPath)
            
            
        } catch {
            print("error")
        }
        rankLabel.morphingEffect = .burn
        lastScore.morphingEffect = .sparkle
        levelLabel.morphingEffect = .burn
        
        switch level {
        case "Beginner":
            levelText = "Beginner"
        case "Intermediate":
            levelText = "Intermediate"
        case "Advanced":
            levelText = "Advanced"
        default:
            break
        }
        levelLabel.text = levelText
        
        
            //制限時間
            lastScore.text = "\(correctAnsNum)問"
            rank = modeSecond/Double(correctAnsNum)
            
        
        rankCheck()
    }
    override func viewWillAppear(_ animated: Bool) {
        audioPlayer.play()
    }
    func rankCheck(){
       
        switch level{
        case "Beginner":
            switch rank {
            case 0..<1.0:
                rankLabel.textColor = UIColor.blue
                rankResult = "SSS"
            case 1.0..<1.5:
                rankLabel.textColor = UIColor.purple
                rankResult = "SS"
            case 1.5..<1.8:
                rankLabel.textColor = UIColor.orange
                rankResult = "S"
            case 1.8..<2.0:
                rankLabel.textColor = UIColor.yellow
                rankResult = "A"
            case 2.0..<2.3:
                rankLabel.textColor = UIColor.yellow
                rankResult = "B"
            case 2.3..<2.5:
                rankLabel.textColor = UIColor.yellow
                rankResult = "C"
            case 2.5..<2.8:
                rankLabel.textColor = UIColor.red
                rankResult = "D"
            case 2.8..<3.0:
                rankLabel.textColor = UIColor.red
                rankResult = "E"
            case 3.0..<3.3:
                rankLabel.textColor = UIColor.red
                rankResult = "F"
            case 3.3..<3.5:
                rankLabel.textColor = UIColor.magenta
                rankResult = "G"
                
            default:
                rankLabel.textColor = UIColor.magenta
                rankResult = "Z"
            }
        case "Intermediate":
            switch rank {
            case 0..<1.0:
                rankLabel.textColor = UIColor.blue
                rankLabel.text = "Super"
            case 1.0..<2.0:
                rankLabel.textColor = UIColor.purple
                rankLabel.text = "Greate!"
            case 2.0..<3.0:
                rankLabel.textColor = UIColor.yellow
                rankLabel.text = "Good!"
            case 3.0..<4.0:
                rankLabel.textColor = UIColor.yellow
                rankLabel.text = "SS"
            case 4.0..<5.0:
                rankLabel.textColor = UIColor.yellow
                rankLabel.text = "S"
            case 5.0..<5.5:
                rankLabel.textColor = UIColor.orange
                rankLabel.text = "A"
            case 5.5..<6.0:
                rankLabel.textColor = UIColor.red
                rankLabel.text = "B"
            case 6.0..<6.5:
                rankLabel.textColor = UIColor.red
                rankLabel.text = "C"
            case 6.5..<7.0:
                rankLabel.textColor = UIColor.red
                rankLabel.text = "D"
            case 7.0..<7.5:
                rankLabel.textColor = UIColor.magenta
                rankLabel.text = "E"
                
            default:
                rankLabel.textColor = UIColor.black
                rankLabel.text = "Z"
                
            }
        case "Advanced":
            switch rank {
            case 0..<2.0:
                rankLabel.textColor = UIColor.blue
                rankLabel.text = "SSS"
            case 2.0..<3.0:
                rankLabel.textColor = UIColor.purple
                rankLabel.text = "SS"
            case 3.0..<4.0:
                rankLabel.textColor = UIColor.orange
                rankLabel.text = "S"
            case 4.0..<5.0:
                rankLabel.textColor = UIColor.yellow
                rankLabel.text = "A"
            case 5.0..<6.0:
                rankLabel.textColor = UIColor.yellow
                rankLabel.text = "B"
            case 6.0..<7.0:
                rankLabel.textColor = UIColor.blue
                rankLabel.text = "C"
            case 7.0..<8.0:
                rankLabel.textColor = UIColor.red
                rankLabel.text = "D"
            case 8.0..<9.0:
                rankLabel.textColor = UIColor.red
                rankLabel.text = "E"
            case 10..<11:
                rankLabel.textColor = UIColor.red
                rankLabel.text = "F"
            case 11..<12:
                rankLabel.textColor = UIColor.magenta
                rankLabel.text = "G"
                
            default:
                rankLabel.textColor = UIColor.black
                rankLabel.text = "Z"
            }
        default:
            break
        }
        
        
    
    }
    

    @IBAction func back(_ sender: UIButton) {
        
        
        audioPlayer.stop()
        self.performSegue(withIdentifier: "toFirst", sender: nil)
    }
    @IBAction func TweetButton(sender: UIButton) {
        
        // 共有する項目
        let shareText = "HANAMARU\n\(levelText)\n\(rankResult!)\n\(lastScore.text!)"
        let shareWebsite = NSURL(string: "https://itunes.apple.com/jp/app/hanamaru/id1450944495?mt=8")!
        
        
        let activityItems = [shareText, shareWebsite] as [Any]
        
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        
        // 使用しないアクティビティタイプ
        let excludedActivityTypes = [
            UIActivity.ActivityType.postToFacebook,
            UIActivity.ActivityType.message,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.print
        ]
        
        activityVC.excludedActivityTypes = excludedActivityTypes
        
        // UIActivityViewControllerを表示
        self.present(activityVC, animated: true, completion: nil)
        
    }

}
