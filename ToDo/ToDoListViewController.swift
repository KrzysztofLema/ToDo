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
    
    let itemArray = ["Find girflend", "go for coffie", "learn code"]
    
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
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

        }
        
    tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}

