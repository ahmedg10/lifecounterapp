//
//  ViewController.swift
//  lifecounter
//
//  Created by Ahmed Ghaddah on 4/19/24.
//

import UIKit
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PlayerTableViewCellDelegate, UITextFieldDelegate {
    @IBOutlet weak var tableView: UITableView!
    var players: [Player] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        initializePlayers()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        // Register the nib file for the cell
        let nib = UINib(nibName: "PlayerTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PlayerCell")
    }
    
    func initializePlayers() {
        for index in 1...2 {  // For example, start with 2 players
            let newPlayerName = "Player \(index)"
            players.append(Player(name: newPlayerName))
        }
        tableView.reloadData()
    }
    
    @IBAction func addPlayerButtonTapped(_ sender: Any) {
        let newPlayerName = "Player \(players.count + 1)"
            players.append(Player(name: newPlayerName))
            let newIndexPath = IndexPath(row: players.count - 1, section: 0)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
    }


    @objc func hideKeyboard() {
        view.endEditing(true)
    }

}

extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as? PlayerTableViewCell else {
            fatalError("Cell with identifier 'PlayerCell' not found")
        }
        
        var player = players[indexPath.row]
        // Configure the cell with data from the players array
        if player.name == "Player" {
            // If the player name is just "Player", append the number
            player.name += " \(indexPath.row + 1)"
        }
        cell.configure(with: player, atIndex: indexPath.row)
        cell.delegate = self
        print("Setting delegate for cell at row \(indexPath.row)")

        return cell
    }
}


extension ViewController {
    func addLifeToPlayer(amount: Int, inCell cell: PlayerTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        players[indexPath.row].lifeTotal += amount
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func subtractLifeFromOthers(amount: Int, inCell cell: PlayerTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        for (index, player) in players.enumerated() where index != indexPath.row {
            player.lifeTotal -= amount
        }
        tableView.reloadData()
    }
    
    func changePlayerName(newName: String, inCell cell: PlayerTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell), !newName.isEmpty else { return }
        players[indexPath.row].name = newName
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}


