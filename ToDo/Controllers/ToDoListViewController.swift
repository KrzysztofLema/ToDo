//
//  ViewController.swift
//  ToDo
//
//  Created by Krzysztof Lema on 21.02.2018.
//  Copyright © 2018 Krzysztof Lema. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    @IBOutlet weak var toDoLabel: UILabel!
    
    var itemArray = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    //MARK - Tablevie DataSource
        

    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell",for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        if itemArray[indexPath.row].done == true {
            cell.accessoryType = .checkmark
            
        }else {
            cell.accessoryType = .none
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if itemArray[indexPath.row].done == false{
                itemArray[indexPath.row].done = true
        }else{
            itemArray[indexPath.row].done = false
        }
        tableView.reloadData()
       tableView.deselectRow(at: indexPath, animated: true)
        
  
    
}
    //TODO - add New Item
    
    @IBAction func addItemButton(_ sender: Any) {
        
        var itemText = UITextField()

        let alert = UIAlertController(title: "Add new to do item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add item", style: .default) { (action) in
            let newItem = Item()
            newItem.title = itemText.text!
            self.itemArray.append(newItem)
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            itemText = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}
