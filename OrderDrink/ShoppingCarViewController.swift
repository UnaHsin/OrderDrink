//
//  ShoppingCarViewController.swift
//  OrderDrink
//
//  Created by Una Lee on 2020/8/17.
//  Copyright © 2020 una.lee. All rights reserved.
//

import UIKit

class ShoppingCarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var totalPriceLab: UILabel!
    
    let commonFunc = CommonFunc.share
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonFunc.setViewController(self)
        
        // 最下方顯示總金額
        getTotalPrice()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    
    @IBAction func sendOrderPressed(_ sender: Any) {
        
        // list.count > 0 才可送出訂單至sheetDB。
        if DrinkListCollectionViewController.orderDrinkList.count > 0 {
            let url = URL(string: ConfigSingleton.SEND_ORDER_URL)!
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let orderDrinkData = OrderDrinkData(data: DrinkListCollectionViewController.orderDrinkList)
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(orderDrinkData) {
                let task = URLSession.shared.uploadTask(with: urlRequest, from: data) { (reData, response, error) in
                    print("send response: \(response)")
                    let decoder = JSONDecoder()
                    if let reData = reData, let statusCode = try? decoder.decode([String:Int].self, from: reData) {
                        print("result code: \(statusCode["created"])")
                        let createdResult = statusCode["created"] ?? 0
                        if createdResult > 0 {
                            DispatchQueue.main.async {
                                self.commonFunc.showAlertAction(message: "訂單已成功送出！", showCancelBtn: false) { (action) in
                                    
                                    DrinkListCollectionViewController.orderDrinkList = []
                                    let controller = self.storyboard!.instantiateViewController(withIdentifier: "MenuView")
                                    self.navigationController!.pushViewController(controller, animated: false)
                                }
                            }
                        }
                    }
                }
                task.resume()
            }
        } else {
            // list.count == 0 ，不可送出訂單，跳出alert提醒，並返回上一頁
            commonFunc.showAlertAction(title: "購物車無品項", message: "請確認飲品後送出。", showCancelBtn: false) { (action) in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func getTotalPrice() {
        var totalPrice = 0
        print("跑getTotalPrice")
        if DrinkListCollectionViewController.orderDrinkList.count > 0 {
            DrinkListCollectionViewController.orderDrinkList.forEach { (orderDrink) in
                print("orderDrink person: \(orderDrink.orderPerson)")
                var drinkPrice = Int(orderDrink.drinkPrice) ?? 0
                totalPrice += drinkPrice
                print("$$ is \(drinkPrice)")
                totalPriceLab.text = "謝謝彼得潘，訂購總金額＄ \(totalPrice)"
            }
        } else {
            totalPriceLab.text = "謝謝彼得潘，大家都很客氣，不用請客了！"
        }
        
    }
    
    //MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DrinkListCollectionViewController.orderDrinkList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cell 不可點擊
        tableView.allowsSelection = false
        
        // 以下為 cell 細節設定
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCarCell", for: indexPath) as! ShoppingCarTableViewCell
        
        let orderDrink = DrinkListCollectionViewController.orderDrinkList[indexPath.item]
        
        cell.orderNameLab.text = orderDrink.orderPerson
        cell.drinkNameLab.text = orderDrink.drinkName
        if "".elementsEqual(orderDrink.addPearl) {
            cell.iceSugarLevelLab.text = "\(orderDrink.drinkIce)、\(orderDrink.drinkSugar)"
        } else {
            cell.iceSugarLevelLab.text = "\(orderDrink.drinkIce)、\(orderDrink.drinkSugar)、\(orderDrink.addPearl)"
        }
        
        cell.drinkPriceLab.text = orderDrink.drinkPrice
        
        
        return cell
    }
    
    //開啟左滑功能
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //刪除的資訊位置
        let select = indexPath.item
        let orderPerson = DrinkListCollectionViewController.orderDrinkList[select].orderPerson
        
        commonFunc.showAlertAction(message: "確定取消「\(orderPerson)」\n的訂單嗎？", showCancelBtn: true) { (action) in
            
            //移除該筆資料
            DrinkListCollectionViewController.orderDrinkList.remove(at: select)
            
            //更新最下方的總金額顯示
            self.getTotalPrice()
            
            tableView.reloadData()
        }
    }
    
    //左滑時顯示的文字
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "刪除"
    }
}
