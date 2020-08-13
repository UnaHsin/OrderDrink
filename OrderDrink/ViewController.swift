//
//  ViewController.swift
//  OrderDrink
//
//  Created by Una Lee on 2020/8/10.
//  Copyright © 2020 una.lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }

    func viewInit() {
        
        
    }

}

