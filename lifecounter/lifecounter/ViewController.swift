//
//  ViewController.swift
//  lifecounter
//
//  Created by Ahmed Ghaddah on 4/19/24.
//

import UIKit
class ViewController: UIViewController{
    
    @IBOutlet weak var GameHistoryButton: UIButton!
    @IBOutlet weak var playerOneAddLivesInputField: UITextField!
    @IBOutlet weak var playerOneMinusLivesInputField: UITextField!
    @IBOutlet weak var playerOnePlusButton: UIButton!
    @IBOutlet weak var playerOneMinusButton: UIButton!

    @IBOutlet weak var playerTwoLabel: UILabel!
    @IBOutlet weak var playerOneLabel: UILabel!
    @IBOutlet weak var PlayerTwoMinusLivesInputField: UITextField!
    @IBOutlet weak var playerTwoAddLivesInputField: UITextField!
    @IBOutlet weak var playerTwoPlusButton: UIButton!
    @IBOutlet weak var playerTwoMinusButton: UIButton!
    @IBOutlet weak var playerTwoLifeCounter: UILabel!
    @IBOutlet weak var playerOneLivesCounter: UILabel!
    
    
    private var playerOneLives = 20
    private var playerTwoLives = 20
    
    var playerOneName = "Player 1"
    var playerTwoName = "Player 2"

   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set initial player names
        playerOneLabel.text = playerOneName
        playerTwoLabel.text = playerTwoName
        
        let playerOneTapGesture = UITapGestureRecognizer(target: self, action: #selector(playerNameTapped(_:)))

        playerOneLabel.isUserInteractionEnabled = true
        playerOneLabel.addGestureRecognizer(playerOneTapGesture)
        
        let playerTwoTapGesture = UITapGestureRecognizer(target: self, action: #selector(playerNameTapped(_:)))
        playerTwoLabel.isUserInteractionEnabled = true
        playerTwoLabel.addGestureRecognizer(playerTwoTapGesture)
        
        
        playerOneAddLivesInputField.keyboardType = .numberPad
        playerOneMinusLivesInputField.keyboardType = .numberPad
        PlayerTwoMinusLivesInputField.keyboardType = .numberPad
        playerTwoAddLivesInputField.keyboardType = .numberPad
        
        GameHistoryButton.addTarget(self, action: #selector(didTapGameHistoryButton), for:.touchUpInside)
        
    }
    
    @objc func didTapGameHistoryButton(){
        print("Game History Pressed")
        let vc = GameHistoryView()
        self.present(vc, animated: true, completion: nil)
        
    }
    private func setupInitialValues(){
        playerOneLabel.text = "Player 1"
        playerTwoLabel.text = "Player 2"
        playerOneLives = 20
        playerTwoLives = 20
        playerOneLivesCounter.text = "\(playerOneLives) Lives"
        playerTwoLifeCounter.text = "\(playerTwoLives) Lives"
        GameHistory.shared.clearHistory()
    }
    
    
    @IBAction func restartGameTapped(_ sender: Any) {
        self.setupInitialValues()
    }
    
    private func checkGameOver() {
            //So, this is trying to filter anything that gets lower than zero
            let activePlayers = [playerOneLives, playerTwoLives].filter { $0 > 0 }
        
            //now if the count of the array falls less than 1 then it shows the alert.
            if activePlayers.count <= 1 {
                let message = "Game over!"
                let alert = UIAlertController(title: "Game Over", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                    self.setupInitialValues()
                })
                present(alert, animated: true)
            }
        }
    

        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func playerNameTapped(_ sender: UITapGestureRecognizer) {
            guard let label = sender.view as? UILabel else { return }
        
            let oldName = label.text ?? ""

            
            // Create an alert controller with a text field for entering the new name
            let alertController = UIAlertController(title: "Enter New Name", message: nil, preferredStyle: .alert)
            alertController.addTextField { textField in
                textField.placeholder = "Enter name"
            }
            
        let confirmAction = UIAlertAction(title: "OK", style: .default) { _ in
                guard let newName = alertController.textFields?.first?.text, !newName.isEmpty else {
                    // Show an alert if the name is empty and return without updating the label
                    self.showAlert(message: "Name cannot be empty. Please enter a name.")
                    return
                }
                
            
                if label == self.playerOneLabel {
                    self.playerOneName = newName
                } else if label == self.playerTwoLabel {
                    self.playerTwoName = newName
                }
                // Update the label with the new name
                label.text = newName
            
                let entry = "Player name changed from \(oldName) to \(newName)"
                GameHistory.shared.addEntry(entry)
            
                print(entry)

            }
            alertController.addAction(confirmAction)
            
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            // Present the alert controller
            present(alertController, animated: true, completion: nil)
        }
    
    @IBAction func playerOneMinusButtonTapped(_ sender: Any) {
        guard let minusAmount = playerOneMinusLivesInputField.text,
              !minusAmount.isEmpty,
              let minusAmount = Int(minusAmount) else {
            showAlert(message: "Please enter a value to minus  lives.")
            // Exit the function because we don't have valid input to work with
            return
        }
        
        playerTwoLives -= minusAmount
        playerTwoLifeCounter.text = "\(playerTwoLives) Lives"
        
        GameHistory.shared.addEntry("\(playerTwoName) lost \(minusAmount) lives.")
        
        playerOneMinusLivesInputField.text = ""
        checkGameOver()
        
    }
    @IBAction func playerOnePlusButtonTapped(_ sender: Any) {
        // Attempt to retrieve the text input from the playerOneAddLivesInputField text field
        guard let additionText = playerOneAddLivesInputField.text,
              // Check if the text is not empty
              !additionText.isEmpty,
              // Try to convert the text to an integer and store it in additionValue
              let additionValue = Int(additionText) else {
                // If the input is empty or not a number, show an alert message to the user
                showAlert(message: "Please enter a value to add lives.")
                // Exit the function because we don't have valid input to work with
                return
        }
        
        playerOneLives += additionValue
        playerOneLivesCounter.text = "\(playerOneLives) Lives"

        GameHistory.shared.addEntry("\(playerOneName) gained \(additionValue) lives.")
        
        print("\(playerOneName) gained \(additionValue) lives.")
        
        playerOneAddLivesInputField.text = ""
        checkGameOver()


        

    }
    
    @IBAction func playerTwoPlusButtonTapped(_ sender: Any) {
        // Attempt to retrieve the text input from the playerOneAddLivesInputField text field
        guard let additionText = playerTwoAddLivesInputField.text,
              // Check if the text is not empty
              !additionText.isEmpty,
              // Try to convert the text to an integer and store it in additionValue
              let additionValue = Int(additionText) else {
                // If the input is empty or not a number, show an alert message to the user
                showAlert(message: "Please enter a value to add lives.")
                // Exit the function because we don't have valid input to work with
                return
        }
        
        playerTwoLives += additionValue
        playerTwoLifeCounter.text = "\(playerTwoLives) Lives"
        
        GameHistory.shared.addEntry("\(playerTwoName) gained \(additionValue) lives.")
        
        print("\(playerTwoName) gained \(additionValue) lives.")
        
        playerTwoAddLivesInputField.text = ""
        checkGameOver()

        

    }
    
    
    @IBAction func playerTwoMinusButtonTapped(_ sender: Any) {
        guard let minusAmount = PlayerTwoMinusLivesInputField.text,
              !minusAmount.isEmpty,
              let minusAmount = Int(minusAmount) else {
            showAlert(message: "Please enter a value to minus  lives.")
            // Exit the function because we don't have valid input to work with
            return
        }
        
        playerOneLives -= minusAmount
        playerOneLivesCounter.text = "\(playerOneLives) Lives"
        
        GameHistory.shared.addEntry("\(playerOneName) lost \(minusAmount) lives.")
        
        print("\(playerOneName) lost \(minusAmount) lives.")
        
        PlayerTwoMinusLivesInputField.text = ""
        
        checkGameOver()
        
    }
    
    

    
    func showAlert(message: String) {
           let alert = UIAlertController(title: "Notice", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true)
       }
    
}

   
