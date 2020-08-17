//
//  ShoppingCarViewController.swift
//  OrderDrink
//
//  Created by Una Lee on 2020/8/17.
//  Copyright © 2020 una.lee. All rights reserved.
//

import UIKit

class ShoppingCarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var orderDrinkList: [OrderDrinkModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
        
        orderDrinkList = DrinkListCollectionViewController.orderDrinkList
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DrinkListCollectionViewController.orderDrinkList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCarCell", for: indexPath) as! ShoppingCarTableViewCell
        
        let orderDrink = orderDrinkList[indexPath.item]
        
        cell.orderNameLab.text = orderDrink.orderPerson
        cell.drinkNameLab.text = orderDrink.drinkName
        cell.iceSugarLevelLab.text = "\(orderDrink.drinkIce)、\(orderDrink.drinkSugar)、珍珠"
        cell.drinkPriceLab.text = orderDrink.drinkPrice
        
        
        return cell
    }
    
}
