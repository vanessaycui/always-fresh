//
//  ItemViewController.swift
//  always-fresh
//
//  Created by Vanessa Cui on 2022-07-14.
//

import UIKit
import CoreData

class ItemViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    //set item array to be an array of Item objects defined in CoreData.
    var itemArray = [Item]()
    
    //create a container to temp store info before committing to CoreData.
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadItems()
        
        //set tableviewcells to customized nib
        tableView.register(UINib(nibName:"ItemCell", bundle: nil), forCellReuseIdentifier:"foodItemCell")
    }

    // MARK: - TABLEVIEW DATASOURCE METHODS
    
  
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = itemArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodItemCell", for: indexPath) as! ItemCell
        cell.item.text = item.title
        cell.quantity.text = item.quantity
        cell.unit.text = item.units
        cell.expiryDate.text = item.expiryDate
        return cell
    }
    
    //MARK: - TABLEVIEW DELEGATE METHODS
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }


    //MARK: - ADD NEW ITEMS
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var itemField = UITextField()
        var dateField = UITextField()
        var quantityField = UITextField()
        var unitField = UITextField()
        //pop-up
        let alert = UIAlertController(title:"Add New Food Item", message: "", preferredStyle: .alert)
        //button
        let action = UIAlertAction(title: "Add", style: .default) { action in
            let newItem = Item(context:self.context)
            newItem.title = itemField.text!
            newItem.expiryDate = dateField.text!
            newItem.quantity = quantityField.text!
            newItem.units = unitField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            self.saveItems()
        }
        
        //textfield
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new Item"
            //extract the textfield inputs to local variable so it can be used outside of this scope.
            itemField = alertTextField
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add Expiry Date: DD/MM/YYY"
            //extract the textfield inputs to local variable so it can be used outside of this scope.
            dateField = alertTextField
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Quantity"
            //extract the textfield inputs to local variable so it can be used outside of this scope.
            quantityField = alertTextField
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Quantity Units"
            //extract the textfield inputs to local variable so it can be used outside of this scope.
            unitField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion:nil)
    }

        


//MARK: - MODEL MANIPULATION

    func saveItems(){
        do{
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
        
        self.tableView.reloadData()
        
        
    }
    //load items with default arguments for Item being fetched being and default predicate for querying.
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        
        do{
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
}
    //MARK: - SEARCH BAR METHODS
extension ItemViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loadItems(with: request)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            DispatchQueue.main.async{
                searchBar.resignFirstResponder()
            }
        }
    }
}
