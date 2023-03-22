//
//  SportViewController.swift
//  Team Up
//
//  Created by Bryan Arambula on 1/8/22.
//

import Foundation
import UIKit
import CoreData


class SportViewController:UIViewController,UITableViewDelegate,UITableViewDataSource{
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadedData()
        sportTableVIew.delegate = self
        sportTableVIew.dataSource = self
        addSportButton.layer.cornerRadius = addSportButton.frame.height / 2
        addSportButton.layer.shadowColor = UIColor.white.cgColor
        addSportButton.layer.shadowRadius = 10
        addSportButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        addSportButton.layer.shadowOpacity = 1
        sportTableVIew.register(UINib(nibName: "SportCell", bundle: nil), forCellReuseIdentifier: "sportNameCell")
    
    }
    
    var sports = ["Soccer", "Basketball"]
    var eventSport = [Sport]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var sportTableVIew:UITableView!
    @IBOutlet weak var addSportButton:UIButton!
    
    
    @IBAction func sportButton(_ sender:UIButton){
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Sport or Event", message: "Below add the sport or name of the event you wish save your team under", preferredStyle: .alert)
        let action = UIAlertAction(title: "ADD", style: .default) { action in
            
            let newSport = Sport(context: self.context)
            newSport.name = textField.text!
            
            self.eventSport.append(newSport)
        }
        
        let cancel = UIAlertAction(title: "CANCEL", style: .cancel) { action in
            print("User has canceled its input")
                                
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        alert.addTextField { sportTextField in
            sportTextField.placeholder = "Ex: Dodgeball / sunday league"
            textField = sportTextField
        }
        
        present(alert, animated: true, completion: nil)
        saveData()
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sportNameCell", for: indexPath) as! SportCell
        cell.sportLabel.text = sports[indexPath.row]
        cell.sportLabel.textColor = UIColor.yellow
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "playerSegue", sender: self)
        
        sportTableVIew.deselectRow(at: indexPath, animated: true)
        
    }
    
    func saveData(){
        do{
            try context.save()
        }catch{
            print("Error saving data into coredata. \(error)")
        }
        sportTableVIew.reloadData()
    }
    
    func loadedData(){
        let request: NSFetchRequest<Sport> = Sport.fetchRequest()
        
        do{
            eventSport = try context.fetch(request)
        }catch{
            print("Error loading data from coredata. \(error)")
        }
        
        sportTableVIew.reloadData()
    }
    
    
    
}
