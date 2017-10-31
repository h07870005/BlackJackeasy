//
//  EndViewController.swift
//  21easy
//
//  Created by Huang Hao on 2017/10/31.
//  Copyright © 2017年 Huang Hao. All rights reserved.
//

import UIKit



class EndViewController: UIViewController {
    var playerChip = 0
    var bankChip = 0

    @IBOutlet weak var messageLabel: UILabel!

    @IBAction func unwindToMultipleChoicePage(segue: UIStoryboardSegue){
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if playerChip == 0 {
            bankChip = bankChip - 1000
            messageLabel.text = "輸到脫光光，被電腦賺走了\(bankChip)元！"
        }
        if bankChip == 0 {
            playerChip = playerChip - 1000
            messageLabel.text = "你是賭神，贏了\(playerChip)元"
        }
        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
