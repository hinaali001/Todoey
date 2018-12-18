//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Hina Ali on 12/14/18.
//  Copyright © 2018 Hina Khalid. All rights reserved.
//

import UIKit
import CoreData
class CategoryViewController: UITableViewController {
    var categoriesArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fileDataPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    override func viewDidLoad() {
        super.viewDidLoad()
        print(fileDataPath!)
        loadData()

    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoriesArray[indexPath.row].name
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier:"goToItems" , sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow
        {
            destinationVC.selectedCategory = categoriesArray[indexPath.row]
        }
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem)
    {
        var textFIELD = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
        let newItem = Category(context: self.context)
        newItem.name = textFIELD.text!
        self.categoriesArray.append(newItem)
        self.saveCategory()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a new category"
            textFIELD = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    func saveCategory()
    {
        do
        {
            try context.save()
        } catch
        {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }
    func loadData()
    {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do {
             categoriesArray = try context.fetch(request)
        } catch  {
             print("Errors fetch data from context, \(error)")
        }
        tableView.reloadData()
    }
    
}
