//
//  DrinkListViewController.swift
//  OrderDrink
//
//  Created by Una Lee on 2020/8/10.
//  Copyright © 2020 una.lee. All rights reserved.
//

import UIKit

class DrinkListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    func viewInit() {
        print("進入viewInit")
        let url = URL(string: ConfigSingleton.GET_DRINK_INFO)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            //print("response: \(response)")
            let decoder = JSONDecoder()
            if let data = data, let decodeData = try? decoder.decode([DrinkModel].self, from: data) {
                //print("drinkList: \(decodeData)")
                decodeData.forEach { (drink) in
                    print("drink: \(drink)")
                    
                }
                
                
                //decodeData.forEach { print("drink: \($0)")}
            }
        }
        task.resume()
    }
}
