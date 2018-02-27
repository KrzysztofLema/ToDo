

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {

    @IBOutlet weak var toDoLabel: UILabel!
    let realm = try! Realm()
    var toDoItems : Results<Item>?
    
    var selectedCategory : Category?{
        didSet{
            loadItems()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell",for: indexPath)
        if let item = toDoItems?[indexPath.row]{
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No items Added"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if let item = toDoItems?[indexPath.row]{
            do{
                try realm.write {
                    realm.delete(item)
//                    item.done = !item.done
                }
            }catch{
                print("Error saving done status, \(error)")
            }
        }
        tableView.reloadData()
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)

//        if toDoItems[indexPath.row].done == false{
//                toDoItems[indexPath.row].done = true
//        }else{
//            toDoItems[indexPath.row].done = false
//        }
//        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
  
    
}
    //TODO - add New Item
    
    @IBAction func addItemButton(_ sender: Any) {
        
        var itemText = UITextField()
       
        let alert = UIAlertController(title: "Add new to do item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "add item", style: .default) { (action) in
            do{
            if let currentCategory = self.selectedCategory{
                try self.realm.write {
                    let newItem = Item()
                    newItem.title = itemText.text!
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                }
                
                }}catch{
                    print("Not able to add item, \(error)")
            }
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            itemText = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
 
    
    func  loadItems(){

        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
   
}
extension ToDoListViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        let predicate  = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text! )
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItems(with:  request, predicate: predicate )
        
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

