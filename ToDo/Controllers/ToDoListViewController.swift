

import UIKit

class ToDoListViewController: UITableViewController {

    @IBOutlet weak var toDoLabel: UILabel!
    
    var itemArray = [Item]()
    
    let dateFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    //MARK - Tablevie DataSource
        loadItems()
        
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
        saveItems()
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
            self.saveItems()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            itemText = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func saveItems(){
        
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dateFilePath!)
        }catch{
            print("Error encoding item array,\(error)")
        }
        self.tableView.reloadData()
    }
    
    func  loadItems(){
    if let data = try? Data(contentsOf: dateFilePath!){
        let decoder = PropertyListDecoder()
        do{
            itemArray =  try decoder.decode([Item].self, from: data)
        }catch{
            print("Error decoding item array, \(error)")}
    }
    
    }
}
