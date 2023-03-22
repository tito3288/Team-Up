//
//  ViewController.swift
//  Team Up
//
//  Created by Bryan Arambula on 12/2/21.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor.yellow
        teamButton.layer.cornerRadius = teamButton.frame.height / 2
        plusPayerButton.layer.cornerRadius = plusPayerButton.frame.height / 2
        playerTableVIew.dataSource = self
        playerTableVIew.register(UINib(nibName: "SportCell", bundle: nil), forCellReuseIdentifier: "sportNameCell")

        
        loadedData()
    }
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var players = [Players]()
    var numberOfTeams = Int()
    
    @IBOutlet weak var playerTableVIew:UITableView!
    @IBOutlet weak var numberOfTeamsLabel: UILabel!
    @IBOutlet weak var teamButton:UIButton!
    @IBOutlet weak var plusPayerButton:UIButton!
    
    
    @IBAction func addPlayerButton(_ sender:UIButton){
        
        var textFields = UITextField()
        
        let alert = UIAlertController(title: "ADD PLAYER", message: "Add player below", preferredStyle: .alert)
        let action = UIAlertAction(title: "ADD", style: .default) { action in
            
            let newData = Players(context: self.context)
            newData.names = textFields.text!
            self.players.append(newData)
            
            self.saveData()
        }
        
        let cancel = UIAlertAction(title: "CANCEL", style: .cancel) { action in
            print("User has cancel their input")
        }
        
        alert.addTextField { alertTextFiled in
            alertTextFiled.placeholder = "Type Player name here"
            textFields = alertTextFiled
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func stepper(_ sender:UIStepper){
        numberOfTeamsLabel.text = String(format: "%.0f", sender.value)
        numberOfTeams = Int(sender.value)
    }
    
    @IBAction func teamUpBUtton(_ sender:UIButton){
        
        performSegue(withIdentifier: "ShufflePlayerNames", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tableVc = segue.destination as! TableViewController
        tableVc.numberOfTeams = numberOfTeams
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sportNameCell", for: indexPath) as! SportCell
        cell.sportLabel.text = "\(players[indexPath.row].names!) - # \(indexPath.row + 1)"
        cell.sportLabel.textColor = UIColor.yellow
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func saveData(){
        do{
            try context.save()
        }catch{
            print("Error saving data. \(error)")
        }
        
        self.playerTableVIew.reloadData()
    }
    
    func loadedData(){
        let request: NSFetchRequest<Players> = Players.fetchRequest()
        
        do{
            players = try context.fetch(request)
        }catch{
            print("Error loading data. \(error)")
        }
    }
    
}

