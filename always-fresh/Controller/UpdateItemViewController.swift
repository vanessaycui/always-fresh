//
//  UpdateItemViewController.swift
//  always-fresh
//
//  Created by Vanessa Cui on 2022-07-20.
//

import UIKit
import CoreData

class UpdateItemViewController: UIViewController {
 
    
    @IBOutlet weak var itemLabel: UITextField!

    @IBOutlet weak var shelfLifeLabel: UILabel!
    
    var itemArray: [Item]?
    var itemManager = ItemManager()
 
    

    var selectedItem: Int?

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        quantityPicker.dataSource = self
//        quantityPicker.delegate = self
               
        itemLabel.text = itemArray![selectedItem!].title
        shelfLifeLabel.text=String(itemArray![selectedItem!].expiryDate)
    }
    

    @IBAction func daysChanged(_ sender: UIStepper) {
        shelfLifeLabel.text = String(format:"%0.0f", sender.value)
    }
    
    
    
    @IBAction func updatePressed(_ sender: UIButton) {
        let updatedItem = itemArray![selectedItem!]
        updatedItem.title = itemLabel.text
        updatedItem.expiryDate = Int32(shelfLifeLabel.text!) ?? 0
                
        saveItems()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - DATA MODEL MANIPULATION METHODS
    
    func saveItems() {
        
        //can throw an error, therefore we mark as a try, have do around it and catch any error
        do{
            try context.save()
        }catch{
            print("Error saving context \(error)")
        }
        
    }
    
}



////MARK: - UIPICKERVIEWDATASOURCE
//extension UpdateItemViewController: UIPickerViewDataSource{
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 2
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return self.itemManager.unitArray[component].count
//    }
//
//}
//
////MARK: - UIPICKERVIEWDELEGATE
//
//extension UpdateItemViewController: UIPickerViewDelegate{
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return itemManager.unitArray[component][row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print(itemManager.unitArray[0][pickerView.selectedRow(inComponent:0)])
//        print(itemManager.unitArray[1][pickerView.selectedRow(inComponent:1)])
//    }
//}
