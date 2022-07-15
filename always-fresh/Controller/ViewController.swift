//
//  ViewController.swift
//  always-fresh
//
//  Created by Vanessa Cui on 2022-07-14.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var goToItems: UIButton!
    @IBOutlet weak var goToRecipes: UIButton!
    @IBOutlet weak var goToScanner: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }

    
    @IBAction func goToItems(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    @IBAction func goToRecipes(_ sender: UIButton) {
        performSegue(withIdentifier: "goToRecipes", sender: self)
    }
}

