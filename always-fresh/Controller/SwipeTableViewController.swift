//
//  SwipeTableViewController.swift
//  always-fresh
//
//  Created by Vanessa Cui on 2022-07-20.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
    }
    
    //DataSource methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //changed all cells identifier to cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodItemCell", for: indexPath) as! ItemCell
        
        cell.delegate = self

        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            
     
            self.updateModel(at: indexPath)
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        
        let moreAction = SwipeAction(style:.default, title: "More"){ action, indexPath in

            self.updateItem(at: indexPath)
            
        }
        moreAction.image = UIImage(named:"more-icon")

        return [deleteAction, moreAction]
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .none
        //options.transitionStyle = .border
        return options
    }
    
    @objc open dynamic func updateModel(at indexPath: IndexPath){
        //update datamodel
    }
    
    
    @objc open dynamic func updateItem(at indexPath: IndexPath){
        //update Item
    }


}
