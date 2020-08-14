//
//  OrderDrinkViewController.swift
//  OrderDrink
//
//  Created by Una Lee on 2020/8/10.
//  Copyright © 2020 una.lee. All rights reserved.
//

import UIKit

class OrderDrinkViewController: UIViewController {
    
    @IBOutlet weak var drinkImg: UIImageView!
    @IBOutlet weak var descriptionLab: UILabel!
    @IBOutlet weak var mediumPriceLab: UILabel!
    @IBOutlet weak var largePriceLab: UILabel!
    
    var drinkInfo: DrinkModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("drinkNumber: \(drinkInfo?.drinkNumber)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
        
        viewInit()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    func viewInit() {
        drinkImg.image = UIImage(named: drinkInfo!.drinkNumber)
        descriptionLab.text = drinkInfo?.description
        mediumPriceLab.text = drinkInfo?.mediumPrice
        largePriceLab.text = drinkInfo?.largePrice
    }
}
