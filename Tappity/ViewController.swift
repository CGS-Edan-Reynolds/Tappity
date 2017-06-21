//
//  ViewController.swift
//  Tappity
//
//  You're rubbish at IT
//
//
//  Created by Edan Reynolds on 29/5/17.
//  Copyright © 2017 Edan Reynolds. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let savedScores = defaults.array(forKey: "scoreArray") {
            highScoreArray = savedScores as! [Int]
        }
        
        if let savedNames = defaults.stringArray(forKey: "nameArray") {
            highScoreNameArray = savedNames
        }
        
        if highScoreArray.count > 0 {
            for i in 1...self.highScoreArray.count {
                self.finalHighScoreArray.append("\(self.highScoreNameArray[i-1]) : \(self.highScoreArray[i-1])")
            }
        }
        
        button.center.x = button.superview!.bounds.width / 2
        button.center.y = button.superview!.bounds.height / 2
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var timeDisplay: UILabel!
    @IBOutlet var scoreDisplay: UILabel!
    @IBOutlet var button: UIButton!
    @IBOutlet weak var highscoreButton: UIButton!
    
    var timeLeft = 30
    var score = 0
    var gameStarted = false
    var randomX: CGFloat!
    var randomY: CGFloat!
    var highScoreNameArray = [String]()
    var highScoreArray = [Int]()
    var finalHighScoreArray = [String]()
    var colourArray = [UIColor.red,UIColor.blue,UIColor.green,UIColor.yellow,UIColor.orange,UIColor.purple,UIColor.magenta,UIColor.black,UIColor.gray]
    var highscoreCheck : String!
    var insertCounter = 0
    
    let defaults = UserDefaults.standard
    
    func resetGame() {
        
        defaults.set(highScoreArray, forKey: "scoreArray")
        defaults.set(highScoreNameArray, forKey: "nameArray")
        
        insertCounter = 0
        timeLeft = 30
        score = 0
        gameStarted = false
        
        scoreDisplay.text = "\(score)"
        timeDisplay.text = "\(timeLeft)"
        
        view.backgroundColor = UIColor.blue
        
        button.center.x = button.superview!.bounds.width / 2
        button.center.y = button.superview!.bounds.height / 2
        
        highscoreButton.isEnabled = true
        highscoreButton.isHidden = false
        
    }
    
    func highScoreAlert() {
        
        let alertController = UIAlertController(title: "Game over!", message:
            "New highscore! Your score was \(self.score). Please enter your name below:", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField { (textField) in
            textField.text = ""
        }
        alertController.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.default,handler: { action in let textField = alertController.textFields![0]
            self.highScoreNameArray.insert(textField.text!, at: self.insertCounter)
            self.finalHighScoreArray.removeAll()
            for i in 1...self.highScoreArray.count {
                self.finalHighScoreArray.append("\(self.highScoreNameArray[i-1]) : \(self.highScoreArray[i-1])")
            }
            self.resetGame()
        }))
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func insertHighScore() {
        
        print("insert counter = \(insertCounter)")
        
        if insertCounter == 10 {
            
            let alertController = UIAlertController(title: "Game over!", message:
                "Your score was \(self.score)", preferredStyle: UIAlertControllerStyle.actionSheet)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: { action in self.resetGame() }))
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            
            if highScoreArray.count == insertCounter {
                
                highScoreArray.insert(score, at: insertCounter)
                
                highScoreAlert()
                
            } else if score >= highScoreArray[insertCounter] {
                
                highScoreArray.insert(score, at: insertCounter)
                
                highScoreAlert()
                
            } else {
                
                insertCounter += 1
                
                insertHighScore()
                
            }
            
        }
        
    }
    
    func secTimer() {
        
        timeLeft = timeLeft - 1
        
        timeDisplay.text = "\(timeLeft)"
        
        if timeLeft != 0 {
            
            let _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                
                self.secTimer()
                
            }
            
        } else {
            
            if highScoreArray.count == 0 {
                
                insertHighScore()
                
            } else {
                
                insertHighScore()
                
            }
            
        }
        
    }
    
    @IBAction func buttonTapped() {
        
        if gameStarted == false {
            
            gameStarted = true
            
            highscoreButton.isEnabled = false
            highscoreButton.isHidden = true
            
            secTimer()
            
        }
        
        button.frame.origin = CGPoint(x: 0, y: 0)
        
        view.backgroundColor = colourArray[Int(arc4random_uniform(8))]
        
        let possibleWidth = button.superview!.bounds.width - button.frame.width
        let possibleHeight = button.superview!.bounds.height - button.frame.height
        
        randomX = CGFloat(arc4random_uniform(UInt32(possibleWidth)))
        randomY = CGFloat(arc4random_uniform(UInt32(possibleHeight)))

        button.center.x = randomX + button.frame.width / 2
        button.center.y = randomY + button.frame.height / 2
        
        score += 1
        
        scoreDisplay.text = "\(score)"
        
    }
    
    @IBAction func highscorePressed(_ sender: Any) {
        
        performSegue(withIdentifier: "highscoreSegue", sender: finalHighScoreArray)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination2 = segue.destination as? HighscoreViewController {
            
            if let name = sender as? Array<Any> {
                
                destination2.scoreArray = name
                
            }
            
        }
        
    }
    
}
