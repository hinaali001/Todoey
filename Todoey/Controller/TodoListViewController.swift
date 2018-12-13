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
    let fileDataPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(fileDataPath)
        let newItem = Item()
        newItem.title = "Find baby"
        itemArray.append(newItem)
        let newItem1 = Item()
        newItem1.title = "Go to store"
        itemArray.append(newItem1)
        let newItem2 = Item()
        newItem2.title = "give candies to baby"
        itemArray.append(newItem2)
        loadData()
        
        
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
        saveItems()
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
            self.saveItems()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func saveItems()
    {
        let encoder = PropertyListEncoder()
        do
        {
           let data = try encoder.encode(itemArray)
           try data.write(to: fileDataPath!)
        }
        catch
        {
            print("Errors encoding items array , \(error)")
        }
        tableView.reloadData()
    }
    
    func loadData()
    {
        if let data = try? Data(contentsOf: fileDataPath!)
        {
            let decoder = PropertyListDecoder()
            do
            {
                itemArray = try decoder.decode([Item].self, from:data)
            }
            catch
            {
                    print("Errors decoding items array , \(error)")
            }
            
        }
    }
}

