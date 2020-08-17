//
//  ShoppingCarTableViewCell.swift
//  OrderDrink
//
//  Created by Una Lee on 2020/8/17.
//  Copyright © 2020 una.lee. All rights reserved.
//

import UIKit

class ShoppingCarTableViewCell: UITableViewCell {

    @IBOutlet weak var orderNameLab: UILabel!
    @IBOutlet weak var drinkNameLab: UILabel!
    @IBOutlet weak var iceSugarLevelLab: UILabel!
    @IBOutlet weak var drinkPriceLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
