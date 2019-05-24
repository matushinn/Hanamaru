//
//  SecondViewController.swift
//  random number
//
//  Created by 大江祥太郎 on 2019/01/27.
//  Copyright © 2019年 shotaro. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var myPickerView: UIPickerView!

    let compos = [[
        "Beginner","Intermediate","Advanced"],["30s","60s","90s","120s","150s"]]
    
    
    var level : String!
    
    var modeSecond :String!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        myPickerView.delegate = self
        myPickerView.dataSource = self
    }
    
    //ピッカービューのコンポーネントの個数を返す
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return compos.count
    }
    
    //各コンポーネントの行数を返す
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let compo = compos[component]
        return compo.count
    }
    
    //各コンポーネントの横幅を返す
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == 0{
            //初級など
            return 200
        }else{
            //時間
            return 160
        }
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    //指定のコンポーネント、行の項目名を返す
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //指定のコンポーネントから指定行の項目名を取り出す
        let item = compos[component][row]
        
        return item
        
    }
    
    //ドラムが回転して項目が選ばれた
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //現在選択している行番号
        let row1 = pickerView.selectedRow(inComponent: 0)
        let row2 = pickerView.selectedRow(inComponent: 1)
        
        //現在選択されている項目名
        var item1 = self.pickerView(pickerView, titleForRow: row1, forComponent: 0)
         var item2 = self.pickerView(pickerView, titleForRow: row2, forComponent: 1)
        
        level = item1
        modeSecond = item2
        print(level)
        print(modeSecond)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQue"{
            //画面取り出す
            let VC = segue.destination as! ViewController
            VC.level = level
            VC.modeSecond = modeSecond
        }
    }
    @IBAction func go(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toQue", sender: nil)
        //ボタンを回転
        let rotationAnimation = CABasicAnimation(keyPath:"transform.rotation.z")
        rotationAnimation.toValue = CGFloat(Double.pi / 180) * 180
        rotationAnimation.duration = 0.3
        rotationAnimation.repeatCount = 1
        sender.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    

   
}
