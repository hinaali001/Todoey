//
//  ViewController.swift
//  Todoey
//
//  Created by Hina Ali on 12/7/18.
//  Copyright © 2018 Hina Khalid. All rights reserved.
//

import UIKit

class TodoListViewController : UITableViewController {
    var itemArray = [Item]()
    let defaults = UserDefaults.standard //database
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let newItem = Item()
        newItem.title = "Find baby"
        itemArray.append(newItem)
        let newItem1 = Item()
        newItem1.title = "Go to store"
        itemArray.append(newItem1)
        let newItem2 = Item()
        newItem2.title = "give candies to baby"
        itemArray.append(newItem2)
        
       if let items = defaults.array(forKey: "TodoListArray") as? [Item]
        {
            itemArray = items
        }
        
    }
    //MARK-Tableview datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        print("cell for row at indexpath")
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
        
    }
    //MARK-Tablevie delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(itemArray[indexPath.row])
        //convert value from itemarrays done property if its true change to false vice versa
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - Add new items
    
    @IBAction func addButtonpressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once user clicks add item on UIAlert
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

