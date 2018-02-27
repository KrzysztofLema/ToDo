

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {

    @IBOutlet weak var toDoLabel: UILabel!
    
    var itemArray = [Item]()
    
    var selectedCategory : Category?{
        didSet{
            loadItems()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
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
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)

        if itemArray[indexPath.row].done == false{
                itemArray[indexPath.row].done = true
        }else{
            itemArray[indexPath.row].done = false
        }
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
  
    
}
    //TODO - add New Item
    
    @IBAction func addItemButton(_ sender: Any) {
        
        var itemText = UITextField()
       
        let alert = UIAlertController(title: "Add new to do item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "add item", style: .default) { (action) in
            let newItem = Item(context: self.context)
            newItem.title = itemText.text!
            newItem.done = false
            self.itemArray.append(newItem)
            self.saveItems()
            newItem.parentCategory = self.selectedCategory
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            itemText = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func saveItems(){
        do{
           try context.save()
        }catch{
            print("Error with saving data to DB, \(error)")
        }
        self.tableView.reloadData()
    }
    
    func  loadItems(with request: NSFetchRequest<Item>=Item.fetchRequest(), predicate: NSPredicate? = nil ){

        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let aditionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, aditionalPredicate])
        }else{
            request.predicate = categoryPredicate
        }
        
//                let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
//                request.predicate = compoundPredicate
       
        
        do{
         itemArray = try context.fetch(request)
        }
        catch{
            print("Error Fetching data from contexr , \(error)")
        }
        tableView.reloadData()
    }
   
}
extension ToDoListViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        let predicate  = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text! )
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
    
        loadItems(with:  request, predicate: predicate )
        tableView.reloadData()
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count==0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        
        }
        
    }
    
}
