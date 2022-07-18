//
//  ItemCell.swift
//  always-fresh
//
//  Created by Vanessa Cui on 2022-07-17.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var item: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var unit: UILabel!
    @IBOutlet weak var expiryDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
