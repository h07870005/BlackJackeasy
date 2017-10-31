//
//  TwentyOneViewController.swift
//  21easy
//
//  Created by Huang Hao on 2017/10/6.
//  Copyright © 2017年 Huang Hao. All rights reserved.
//

import UIKit
import GameplayKit

class TwentyOneViewController: UIViewController {
    //莊家的牌
    @IBOutlet weak var Pic1: UIImageView!
    @IBOutlet weak var Pic2: UIImageView!
    @IBOutlet weak var Pic3: UIImageView!
    @IBOutlet weak var Pic4: UIImageView!
    @IBOutlet weak var Pic5: UIImageView!
    //--------------------------------------------
    //玩家的牌
    
    @IBOutlet weak var Pic6: UIImageView!
    @IBOutlet weak var Pic7: UIImageView!
    @IBOutlet weak var Pic8: UIImageView!
    @IBOutlet weak var Pic9: UIImageView!
    @IBOutlet weak var Pic10: UIImageView!

    @IBOutlet weak var bankBackground: UIImageView!
    @IBOutlet weak var playerBackground: UIImageView!
    
    
    @IBOutlet weak var BankChip: UILabel!
    @IBOutlet weak var PlayerChip: UILabel!
    @IBOutlet weak var YesButton: UIButton!
    @IBOutlet weak var WantButoon: UIButton!
    @IBOutlet weak var ResultButoon: UIButton!
    
    @IBOutlet weak var BankScoreLabel: UILabel!
    @IBOutlet weak var PlayerScoreLabel: UILabel!
   
    
    
    
    //變數宣告
    
    var number = 0
    var score = 0
    var count = 0
    var numberRandom = GKShuffledDistribution(lowestValue: 1, highestValue:array.count-1 )
    var playerScore = 0
    var bankScore = 0
    var playerChip = 1000
    var bankChip = 1000
    
    
    //發牌按鈕
    @IBAction func Yes(_ sender: UIButton) {
        發牌()
        YesButton.isEnabled = false
        WantButoon.isEnabled = true
        ResultButoon.isEnabled = true


        
    }
    func 發牌(){
        bankBackground.isHidden = false
        playerBackground.isHidden = false
        number = numberRandom.nextInt()
        Pic1.image = UIImage(named: array[number].name)
        bankScore += array[number].score
        Pic1.isHidden = true
        number = numberRandom.nextInt()
        Pic6.image = UIImage(named: array[number].name)
        playerScore += array[number].score
        Pic6.isHidden = true
        print("玩家的點數\(playerScore)")
        print("莊家的點數\(bankScore)")
    }
    
    
    //要牌按鈕
    @IBAction func WantButton(_ sender: UIButton) {
        要牌()
        print("玩家的點數\(playerScore)")
        print("莊家的點數\(bankScore)")
        
    }
    func 要牌(){
        count = count + 1
        if count == 1 && playerScore <= 21{
        number = numberRandom.nextInt()
        Pic7.image = UIImage(named: array[number].name)
        playerScore += array[number].score
        PlayerScoreLabel.text = "\(playerScore)"
        Pic7.isHidden = false
        }
        if count == 2 && playerScore <= 21{
        number = numberRandom.nextInt()
        Pic8.image = UIImage(named: array[number].name)
        playerScore += array[number].score
        PlayerScoreLabel.text = "\(playerScore)"
        Pic8.isHidden = false
        }
        
        if count == 3 && playerScore <= 21{
        number = numberRandom.nextInt()
        Pic9.image = UIImage(named: array[number].name)
        playerScore += array[number].score
        PlayerScoreLabel.text = "\(playerScore)"
        Pic9.isHidden = false
        }
        
        if count == 4 && playerScore <= 21{
        number = numberRandom.nextInt()
        Pic10.image = UIImage(named: array[number].name)
        playerScore += array[number].score
        PlayerScoreLabel.text = "\(playerScore)"
        Pic10.isHidden = false
        YesButton.isEnabled = false
        WantButoon.isEnabled = false
        }

        
        if count >= 5 {
            count = 0
        }
        
        if playerScore > 21 {
            bust()
        }
        if playerScore == 21 {
            win()
        }
    }

    
    
    func next(){
        var numberRandom = GKShuffledDistribution(lowestValue: 1, highestValue: array.count-1)
        if playerChip == 0 || bankChip == 0 {
            performSegue(withIdentifier: "EndSegue", sender: nil)
        }
        Pic1.isHidden = true
        Pic2.isHidden = true
        Pic3.isHidden = true
        Pic4.isHidden = true
        Pic5.isHidden = true
        Pic6.isHidden = true
        Pic7.isHidden = true
        Pic8.isHidden = true
        Pic9.isHidden = true
        Pic10.isHidden = true
        
        bankScore = 0
        playerScore = 0
        count = 0
        
        
        YesButton.isEnabled = true
        WantButoon.isEnabled = false
        ResultButoon.isEnabled = false
        
        BankChip.text = "莊家籌碼:$\(bankChip)"
        PlayerChip.text = "玩家籌碼:$\(playerChip)"
        BankScoreLabel.text = ""
        PlayerScoreLabel.text = ""
    }
    
    func Okhandler(action: UIAlertAction){
        next()
    }
    
    // 輸了通知
    func lose(){
        let controller = UIAlertController(
            title: "你輸了！",
            message:"分數：\(playerScore)" ,
            preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "再接再厲", style: UIAlertActionStyle.default, handler: Okhandler)
        controller.addAction(action)
        show(controller, sender: nil)
        playerChip = playerChip - 100
        bankChip = bankChip + 100
        print("玩家的籌碼\(playerChip)")
        print("莊家的籌碼\(bankChip)")
        
        playerBackground.isHidden = true
        bankBackground.isHidden = true
        Pic1.isHidden = false
        Pic6.isHidden = false
        


    }
    
    // 贏了通知
    func win(){
        let controller = UIAlertController(
            title: "恭喜你贏了！",
            message:"分數：\(playerScore)" ,
            preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "知道了", style: UIAlertActionStyle.default, handler: Okhandler)
        controller.addAction(action)
        show(controller, sender: nil)
        playerChip = playerChip + 100
        bankChip = bankChip - 100
        print("玩家的籌碼\(playerChip)")
        print("莊家的籌碼\(bankChip)")
        
        playerBackground.isHidden = true
        bankBackground.isHidden = true
        Pic1.isHidden = false
        Pic6.isHidden = false
        


    }
    // 分數爆掉通知
    func bust (){
        let controller = UIAlertController(
            title: "爆了！",
            message: "分數：\(playerScore)",
            preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: Okhandler)
        controller.addAction(action)
        show(controller, sender: nil)
        playerChip = playerChip - 100
        bankChip = bankChip + 100
        print("玩家的籌碼\(playerChip)")
        print("莊家的籌碼\(bankChip)")
        
        playerBackground.isHidden = true
        bankBackground.isHidden = true
        Pic1.isHidden = false
        Pic6.isHidden = false
        


        
        
    }
    // 平手通知
    func even (){
        let controller = UIAlertController(
            title: "平手！",
            message: "分數：\(playerScore)",
            preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "再來一次", style: UIAlertActionStyle.default, handler: Okhandler)
        controller.addAction(action)
        show(controller, sender: nil)
        
        playerBackground.isHidden = true
        bankBackground.isHidden = true
        Pic1.isHidden = false
        Pic6.isHidden = false

        print("玩家的籌碼\(playerChip)")
        print("莊家的籌碼\(bankChip)")

    }
    
    //輸贏按鈕
    
    @IBAction func Result(_ sender: UIButton) {
        
        Pic1.isHidden = false
        Pic6.isHidden = false
        bankBackground.isHidden = true
        playerBackground.isHidden = true
        
        while bankScore < 14 {
            number = numberRandom.nextInt()
            Pic2.image = UIImage(named: array[number].name)
            bankScore += array[number].score
            Pic2.isHidden = false
            number = numberRandom.nextInt()
            Pic3.image = UIImage(named: array[number].name)
            bankScore += array[number].score
            Pic3.isHidden = false
        }
        BankScoreLabel.text = "\(bankScore)"
        
        if playerScore > bankScore || bankScore > 21 || count >= 4 && playerScore <= 21{
            win()
        }else if bankScore > playerScore {
            lose()
        }else if playerScore == bankScore {
            even()
        }
    }
    
   
    
    
    
    @IBAction func unwindToMultipleChoicePage(segue: UIStoryboardSegue) {
        playerChip = 1000
        bankChip = 1000
        next()
    }

    
    
   



    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        BankScoreLabel.text = ""
        PlayerScoreLabel.text = ""
        bankBackground.isHidden = true
        playerBackground.isHidden = true
        
    

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let controller = segue.destination as! EndViewController
        controller.bankChip = bankChip
        controller.playerChip = playerChip
        
    }
    

}
