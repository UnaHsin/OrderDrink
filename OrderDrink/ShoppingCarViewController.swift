//
//  ShoppingCarViewController.swift
//  OrderDrink
//
//  Created by Una Lee on 2020/8/17.
//  Copyright © 2020 una.lee. All rights reserved.
//

import UIKit

class ShoppingCarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let commonFunc = CommonFunc.share
    var orderDrinkList: [OrderDrinkModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        commonFunc.setViewController(self)
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
    
    
    @IBAction func sendOrderPressed(_ sender: Any) {
        self.commonFunc.showAlertAction(message: "訂單已成功送出！", showCancelBtn: false) { (action) in
            DispatchQueue.main.async {
                DrinkListCollectionViewController.orderDrinkList = []
                let controller = self.storyboard!.instantiateViewController(withIdentifier: "MenuView")
                self.navigationController!.pushViewController(controller, animated: false)
            }
        }
        
//        let url = URL(string: ConfigSingleton.SEND_ORDER_URL)!
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "POST"
//        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        let orderDrinkData = OrderDrinkData(data: orderDrinkList)
//        let encoder = JSONEncoder()
//        if let data = try? encoder.encode(orderDrinkData) {
//            let task = URLSession.shared.uploadTask(with: urlRequest, from: data) { (reData, response, error) in
//                print("send response: \(response)")
//                let decoder = JSONDecoder()
//                if let reData = reData, let statusCode = try? decoder.decode([String:Int].self, from: reData) {
//                    print("result code: \(statusCode["created"])")
//                    let createdResult = statusCode["created"] ?? 0
//                    if createdResult > 0 {
//                        self.commonFunc.showAlertAction(message: "訂單已成功送出！") { (action) in
//                            DispatchQueue.main.async {
//                                DrinkListCollectionViewController.orderDrinkList = []
//                                let controller = self.storyboard!.instantiateViewController(withIdentifier: "MenuView")
//                                self.navigationController!.pushViewController(controller, animated: false)
//                            }
//                        }
//                    }
//                }
//            }
//            task.resume()
//        }
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
