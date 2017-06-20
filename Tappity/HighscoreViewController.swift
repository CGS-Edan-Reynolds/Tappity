//
//  HighscoreViewController.swift
//  Tappity
//
//  Created by Edan Reynolds on 30/5/17.
//  Copyright © 2017 Edan Reynolds. All rights reserved.
//

import UIKit

class HighscoreViewController: UIViewController {

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    @IBOutlet weak var labelFour: UILabel!
    @IBOutlet weak var labelFive: UILabel!
    @IBOutlet weak var labelSix: UILabel!
    @IBOutlet weak var labelSeven: UILabel!
    @IBOutlet weak var labelEight: UILabel!
    @IBOutlet weak var labelNine: UILabel!
    @IBOutlet weak var labelTen: UILabel!
    
    private var highScoreArray = Array<Any>()
    
    var scoreArray : Array<Any> {
        
        get {
            return highScoreArray
        } set {
            highScoreArray = newValue
        }
        
    }
    
    func updateText() {
        
        var outletArray = [labelOne,labelTwo,labelThree,labelFour,labelFive,labelSix,labelSeven,labelEight,labelNine,labelTen]
        
        if highScoreArray.count != 0 {
            
            for i in 1...highScoreArray.count {
            
                outletArray[i-1]?.text = "\(highScoreArray[i-1])"
            
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        updateText()
    
    }
    
}
