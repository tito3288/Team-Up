//
//  TableViewController.swift
//  Team Up
//
//  Created by Bryan Arambula on 12/17/21.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = UIColor.yellow
        loadedShuffledPlayers()
        tableView.reloadData()
        tableView.register(UINib(nibName: "ShuffledTableViewCell", bundle: nil), forCellReuseIdentifier: "shuffledCell")
        
    }
    
    var players2 = [Players]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var numberOfTeams = Int()
    var seatcionHeader = [String]()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return players2.count / numberOfTeams

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shuffledCell", for: indexPath) as! ShuffledTableViewCell
        
        let rowsPerSection = players2.count / numberOfTeams
        let rowInSection = indexPath.row + rowsPerSection * indexPath.section

        cell.shuffledLabel.text = players2[rowInSection].names
        cell.backgroundColor = UIColor.black
        return cell
    }
    
    func loadedShuffledPlayers(){
        
        let request: NSFetchRequest<Players> = Players.fetchRequest()
        do{
            players2 = try context.fetch(request).shuffled()
        }catch{
            print("Error fecthing data .\(error)")
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfTeams
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Team # \(section + 1)"

    }
 
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    
    
}


   


