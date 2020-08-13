//
//  MenuViewController.swift
//  OrderDrink
//
//  Created by Una Lee on 2020/8/13.
//  Copyright © 2020 una.lee. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var orderBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewInit()
        
        btnInit()
    }
    

    func viewInit() {
        //orderBtn.setTitle("立即\n點餐", for: .normal)
    }
    
    func btnInit() {
        orderBtn.layer.cornerRadius = 5
    }

}
