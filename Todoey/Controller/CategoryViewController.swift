//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Hina Ali on 12/14/18.
//  Copyright © 2018 Hina Khalid. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift
class CategoryViewController: UITableViewController {
    var categoriesArray : Results<Category>?
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()

    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoriesArray?[indexPath.row].name ?? "No Categories added yet."
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier:"goToItems" , sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow
        {
            destinationVC.selectedCategory = categoriesArray?[indexPath.row]
        }
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem)
    {
        var textFIELD = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
        let newItem = Category()
        newItem.name = textFIELD.text!
        self.save(category : newItem)
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a new category"
            textFIELD = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    func save(category : Category)
    {
        do
        {
            try realm.write {
                realm.add(category)
            }
        } catch
        {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }
   func loadData()
    {
        categoriesArray = realm.objects(Category.self)
        tableView.reloadData()
    }
    
}
