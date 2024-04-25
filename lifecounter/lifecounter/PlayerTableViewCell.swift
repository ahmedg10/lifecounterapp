//
//  PlayerTableViewCell.swift
//  lifecounter
//
//  Created by Ahmed Ghaddah on 4/24/24.
//
import UIKit

class PlayerTableViewCell: UITableViewCell, UITextFieldDelegate{

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var addLifeTextField: UITextField!
    @IBOutlet weak var subtractLifeTextField: UITextField!
    @IBOutlet weak var lifeLabel: UILabel!
    
    // Assuming you have a delegate protocol for cell actions
    weak var delegate: PlayerTableViewCellDelegate?
       
       override func awakeFromNib() {
           super.awakeFromNib()
           // Optionally set the keyboard type for the life text fields to number pad.
           addLifeTextField.keyboardType = .numberPad
           subtractLifeTextField.keyboardType = .numberPad
       }
       
    func configure(with player: Player, atIndex index: Int) {
        playerNameLabel.text = "Player \(index + 1): \(player.name)"
        lifeLabel.text = "\(player.lifeTotal) Lives"
    }
       

       // Plus button action
       @IBAction func plusButtonTapped(_ sender: UIButton) {
           if let amountText = addLifeTextField.text, let amount = Int(amountText), amount > 0 {
               delegate?.addLifeToPlayer(amount: amount, inCell: self)
           }
       }
       
       // Minus button action
       @IBAction func minusButtonTapped(_ sender: UIButton) {
           if let amountText = subtractLifeTextField.text, let amount = Int(amountText), amount > 0 {
               delegate?.subtractLifeFromOthers(amount: amount, inCell: self)
           }
       }
       
       // Prepare for cell reuse
       override func prepareForReuse() {
           super.prepareForReuse()
           // Reset the cell to its default state
           playerNameLabel.text = "New Player"
           lifeLabel.text = "20"
           addLifeTextField.text = ""
           subtractLifeTextField.text = ""
       }
   }

   // Define the delegate protocol that the ViewController will conform to.
   protocol PlayerTableViewCellDelegate: AnyObject {
       func addLifeToPlayer(amount: Int, inCell cell: PlayerTableViewCell)
       func subtractLifeFromOthers(amount: Int, inCell cell: PlayerTableViewCell)
       func changePlayerName(newName: String, inCell cell: PlayerTableViewCell)
   }
