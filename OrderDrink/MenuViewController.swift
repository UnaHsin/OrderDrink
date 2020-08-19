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
    
    var drinkList: [DrinkModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewInit()
        
        btnInit()
        
        //getDrinkInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }


    func viewInit() {
        //orderBtn.isHidden = true
    }
    
    func btnInit() {
        orderBtn.layer.cornerRadius = 5
    }
    
    func getDrinkInfo() {
        let url = URL(string: ConfigSingleton.GET_DRINK_INFO_URL)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            //print("response: \(response)")
            let decoder = JSONDecoder()
            if let data = data, let decodeData = try? decoder.decode([DrinkModel].self, from: data) {
                //print("drinkList: \(decodeData)")
                self.drinkList = decodeData
                decodeData.forEach { (drink) in
                    print("drink: \(drink)")
                    
                }
                if self.drinkList.count > 1  && self.drinkList != nil {
                    //在main thread中，變換UI
                    DispatchQueue.main.sync {
                        self.orderBtn.isHidden = false
                    }
                }
                //decodeData.forEach { print("drink: \($0)")}
            }
        }
        task.resume()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoDrinkListCollection" {
            DrinkListCollectionViewController.drinkList = drinkList
        }
    }
}
