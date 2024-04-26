//
//  GameHistoryView.swift
//  lifecounter
//
//  Created by Ahmed Ghaddah on 4/25/24.
//

import UIKit

class GameHistoryView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    var historyEntries: [String] {
        return GameHistory.shared.entries.isEmpty ? ["No game history"] : GameHistory.shared.entries
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        if tableView == nil {
            print("Table view is not working")
        } else{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.reloadData()

            
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
        cell.textLabel?.text = historyEntries[indexPath.row]
        return cell
    }
}
