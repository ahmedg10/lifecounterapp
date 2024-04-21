//
//  ViewController.swift
//  lifecounter
//
//  Created by Ahmed Ghaddah on 4/19/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var player1LifeLabel: UILabel!
    
    
    @IBOutlet weak var plus5Player2Button: UIButton!
    @IBOutlet weak var Player2LabelForRotation: UILabel!
    
    @IBOutlet weak var player2LifeLabel: UILabel!
    
    @IBOutlet weak var minusFivePlayer1: UIButton!
    
    @IBOutlet weak var player2MinusButton: UIButton!
    
    @IBOutlet weak var player2PlusButton: UIButton!
    
    @IBOutlet weak var minus1Player2: UIButton!
    @IBOutlet weak var Player1PlusButton: UIButton!
    @IBOutlet weak var plusFivePlayer1: UIButton!
    var player1LifeCounter = 20
    var player2LifeCounter = 20
    
    @IBOutlet weak var winnerLabel: UILabel!
    func updateLifeLabels() {
        player1LifeLabel.text = "\(player1LifeCounter) Lives"
        player2LifeLabel.text = "\(player2LifeCounter) Lives"
        
        // Check for losing condition
           if player1LifeCounter <= 0 {
               player1LifeLabel.text = "0 Lives"  // Ensure it shows 0 and not a negative number
               winnerLabel.text = "Player 1 LOSES!"
               winnerLabel.isHidden = false
               disableGameControls()  // Disable controls as Player 2 has lost

           } else if player2LifeCounter <= 0 {
               player2LifeLabel.text = "0 Lives"
               winnerLabel.text = "Player 2 LOSES!"
               winnerLabel.isHidden = false
               disableGameControls()  // Disable controls as Player 2 has lost

           } else {
               winnerLabel.isHidden = true // Hide the label if no one has lost
           }
    }
    
    func disableGameControls() {
        plus5Player2Button.isEnabled = false
        player2MinusButton.isEnabled = false
        player2PlusButton.isEnabled = false
        minusFivePlayer1.isEnabled = false
        Player1PlusButton.isEnabled = false
        minus1Player2.isEnabled = false
        plusFivePlayer1.isEnabled = false
        
    }
        
    @IBAction func minusOnePlayer1(_ sender: Any) {
        player1LifeCounter -= 1
        updateLifeLabels()
    }
    
    @IBAction func plusPlayer1(_ sender: Any) {
        player1LifeCounter += 1
        updateLifeLabels()
    }
    @IBAction func plusOnePlayer2(_ sender: Any) {
        player2LifeCounter += 1
        updateLifeLabels()
    }
    
    @IBAction func minusPlayer2(_ sender: Any) {
        player2LifeCounter -= 1
        updateLifeLabels()
    }
    @IBAction func plusFivePlayer1(_ sender: Any) {
        player1LifeCounter += 5
        updateLifeLabels()
    }
    @IBAction func plus5Player2(_ sender: Any) {
        player2LifeCounter += 5
        updateLifeLabels()
    }
    @IBAction func minusFivePlayer2(_ sender: Any) {
        player2LifeCounter -= 5
        updateLifeLabels()
    }
    @IBAction func minusFivePlayer1(_ sender: Any) {
        player1LifeCounter -= 5
        updateLifeLabels()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize UI elements here
        updateLifeLabels() // Update labels with initial life counts
    }
}

