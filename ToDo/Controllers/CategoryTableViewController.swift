//
//  CategoryTableViewController.swift
//  ToDo
//
//  Created by Krzysztof Lema on 26.02.2018.
//  Copyright © 2018 Krzysztof Lema. All rights reserved.
//

import UIKit
import CoreData
class CategoryTableViewController: UITableViewController {

    var categoryArray=[Category]()
    
  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()

       
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return categoryArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
      if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
        
        
    }
    
    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "add category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)
            self.saveCategory()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveCategory(){
        do{
           try context.save()
            
        }catch{
            print("Error with saving data, \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategory(with request:NSFetchRequest<Category> = Category.fetchRequest()){
        do{
            categoryArray = try context.fetch(request)
            
        }catch{
            print("Error fetching data with context, \(error)")
        }
        tableView.reloadData()
    }
 

}


