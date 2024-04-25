//
//  PlayerTableViewCell.swift
//  lifecounter
//
//  Created by Ahmed Ghaddah on 4/24/24.
//
import UIKit

import UIKit

class PlayerTableViewCell: UITableViewCell {

    static let identifier = "PlayerTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "PlayerTableViewCell", bundle: nil)
    }

    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var lifeLabel: UILabel!
    @IBOutlet weak var addLifeTextField: UITextField!
    @IBOutlet weak var subtractLifeTextField: UITextField!
    

    @IBOutlet weak var minusButton: UIButton!
    
    weak var delegate: PlayerTableViewCellDelegate?
    
    override func awakeFromNib() {
            super.awakeFromNib()
            
            // Set the keyboard type to number pad for the text fields
            addLifeTextField.keyboardType = .numberPad
            subtractLifeTextField.keyboardType = .numberPad

            // Setup cell UI based on the storyboard configuration
            setupCellAppearance()
        }
    
    private func setupCellAppearance() {
            // Set the colors and other UI elements here to match the storyboard design
            // For example, if you have set specific colors for your buttons in the storyboard:
            plusButton.backgroundColor = .systemGreen
            minusButton.backgroundColor = .systemRed
            
            // Set up label colors if needed
            playerNameLabel.textColor = .black
            lifeLabel.textColor = .black
            
            // Set any border, corner radius, or other visual properties
            plusButton.layer.cornerRadius = plusButton.bounds.height / 2
            minusButton.layer.cornerRadius = minusButton.bounds.height / 2
        }



    @IBAction func plusButtonTapped(_ sender: UIButton) {
        if let amountText = addLifeTextField.text, let amount = Int(amountText), amount > 0 {
            delegate?.addLifeToPlayer(amount: amount, inCell: self)
        }
    }
    
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        if let amountText = subtractLifeTextField.text, let amount = Int(amountText), amount > 0 {
            delegate?.subtractLifeFromOthers(amount: amount, inCell: self)
        }
    }
    
    func configure(with player: Player, atIndex index: Int) {
        playerNameLabel.text = "Player \(index + 1)"
        lifeLabel.text = "\(player.lifeTotal) Lives"
        
        setupCellAppearance()

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playerNameLabel.text = "New Player"
        lifeLabel.text = "20 Lives"
        addLifeTextField.text = ""
        subtractLifeTextField.text = ""
    }
}

protocol PlayerTableViewCellDelegate: AnyObject {
    func addLifeToPlayer(amount: Int, inCell cell: PlayerTableViewCell)
    func subtractLifeFromOthers(amount: Int, inCell cell: PlayerTableViewCell)
}
