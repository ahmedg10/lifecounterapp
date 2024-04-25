//
//  ViewController.swift
//  lifecounter
//
//  Created by Ahmed Ghaddah on 4/19/24.
//

import UIKit
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PlayerTableViewCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    var players: [Player] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(PlayerTableViewCell.nib(), forCellReuseIdentifier: PlayerTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        initializePlayers()
    }
    
    func initializePlayers() {
        for index in 1...4 {  // Example to start with 4 players
            players.append(Player(name: "Player \(index)", lifeTotal: 20))
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlayerTableViewCell.identifier, for: indexPath) as? PlayerTableViewCell else {
            fatalError("Cell with identifier \(PlayerTableViewCell.identifier) not found")
        }
        let player = players[indexPath.row]
        cell.configure(with: player, atIndex: indexPath.row)
        cell.delegate = self
        return cell
    }

    func addLifeToPlayer(amount: Int, inCell cell: PlayerTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        players[indexPath.row].lifeTotal += amount
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func subtractLifeFromOthers(amount: Int, inCell cell: PlayerTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        for (index, _) in players.enumerated() where index != indexPath.row {
            players[index].lifeTotal -= amount
        }
        tableView.reloadData()
    }
}
