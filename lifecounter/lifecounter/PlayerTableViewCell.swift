//
//  PlayerTableViewCell.swift
//  lifecounter
//
//  Created by Ahmed Ghaddah on 4/24/24.
//
import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var playerNameTextField: UITextField!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var addLifeTextField: UITextField!
    @IBOutlet weak var subtractLifeTextField: UITextField!
    @IBOutlet weak var lifeLabel: UILabel!
    
    // Assuming you have a delegate protocol for cell actions
    weak var delegate: PlayerTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupDefaultNames()
    }
    
    func configure(with player: Player) {
        playerNameTextField.text = player.name
        lifeLabel.text = "\(player.lifeTotal) Lives"
    }

    @IBAction func plusButtonTapped(_ sender: UIButton) {
        if let amountText = addLifeTextField.text, let amount = Int(amountText), amount > 0 {
            delegate?.addLifeToPlayer(amount: amount, inCell: self)
        }
    }

    // Action for the minus button
    @IBAction func minusButtonTapped(_ sender: UIButton) {
        if let amountText = subtractLifeTextField.text, let amount = Int(amountText), amount > 0 {
            delegate?.subtractLifeFromOthers(amount: amount, inCell: self)
        }
    }
    
    private func setupDefaultNames() {
        // Logic to set default names like "Player 1", "Player 2", etc.
    }
    
    // Call this method when the cell is about to be reused
    override func prepareForReuse() {
        super.prepareForReuse()
        addLifeTextField.text = nil
        subtractLifeTextField.text = nil
        // Reset any other dynamic states or fields if necessary
    }
}

protocol PlayerTableViewCellDelegate: AnyObject {
    func addLifeToPlayer(amount: Int, inCell cell: PlayerTableViewCell)
    func subtractLifeFromOthers(amount: Int, inCell cell: PlayerTableViewCell)
    func changePlayerName(newName: String, inCell cell: PlayerTableViewCell)
}
