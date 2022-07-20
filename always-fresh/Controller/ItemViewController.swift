//
//  ItemViewController.swift
//  always-fresh
//
//  Created by Vanessa Cui on 2022-07-14.
//

import UIKit
import CoreData


class ItemViewController: SwipeTableViewController{
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //set item array to be an array of Item objects defined in CoreData.
    var itemArray = [Item]()
    
    //create a container to temp store info before committing to CoreData.
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadItems()
        
//        set tableviewcells to customized nib
        tableView.register(UINib(nibName:"ItemCell", bundle: nil), forCellReuseIdentifier:"foodItemCell")
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {

        loadItems()
    }
  

    // MARK: - TABLEVIEW DATASOURCE METHODS

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = itemArray[indexPath.row]
        let cell = super.tableView(tableView, cellForRowAt: indexPath) as! ItemCell
        cell.item.text = item.title
        cell.quantity.text = item.quantity
        cell.unit.text = item.units
        cell.expiryDate.text = item.expiryDate
        
        return cell
    }
    
    //MARK: - TABLEVIEW DELEGATE METHODS
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
              
        
        tableView.deselectRow(at: indexPath, animated: true)
    }


    //MARK: - ADD NEW ITEMS
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

        performSegue(withIdentifier: "goToAddItem", sender: self)

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
        
        request.sortDescriptors = [NSSortDescriptor (key:"expiryDate", ascending: true)]
        
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
    
    // MARK: DELETE DATA FROM SWIPE
    override func updateModel(at indexPath: IndexPath) {
        print(itemArray.count)
        context.delete(itemArray[indexPath.row])
        itemArray.remove(at:indexPath.row)
        print(itemArray.count)

        saveItems()

    }
}

