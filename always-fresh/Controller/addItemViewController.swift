//
//  addItemViewController.swift
//  always-fresh
//
//  Created by Vanessa Cui on 2022-07-18.
//

import UIKit
import CoreData


class addItemViewController: UIViewController {
  
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var shelfLifeLabel: UILabel!
    @IBOutlet weak var unitPicker: UIPickerView!
    
    var ItemArray = [Item]()
    
    var itemManager = ItemManager()
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        unitPicker.dataSource = self
        unitPicker.delegate = self
    }
    
    
    
    
    @IBAction func daysValueChanged(_ sender: UIStepper) {
        shelfLifeLabel.text = String(format: "%0.0f",sender.value)
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        let newItem = Item(context: self.context)
        newItem.title = itemName.text
        newItem.expiryDate = shelfLifeLabel.text
        
        
        
        saveItems()
       
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated:true, completion:nil)
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

//MARK: - UIPICKERVIEWDATASOURCE
extension addItemViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.itemManager.unitArray[component].count
    }
    
}

//MARK: - UIPICKERVIEWDELEGATE

extension addItemViewController: UIPickerViewDelegate{

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return itemManager.unitArray[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(itemManager.unitArray[0][pickerView.selectedRow(inComponent:0)])
        print(itemManager.unitArray[1][pickerView.selectedRow(inComponent:1)])
    }
}
