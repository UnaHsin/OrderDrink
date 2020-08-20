//
//  OrderDrinkModel.swift
//  OrderDrink
//
//  Created by Una Lee on 2020/8/17.
//  Copyright © 2020 una.lee. All rights reserved.
//

import Foundation

struct OrderDrinkModel: Codable {
    var orderPerson: String
    var drinkName: String
    var drinkSize: String
    var drinkIce: String
    var drinkSugar: String
    var addPearl: String
    var drinkPrice: String
    
    enum CodingKeys: String, CodingKey {
        case orderPerson = "orderPerson"
        case drinkName = "drinkName"
        case drinkSize = "drinkSize"
        case drinkIce = "drinkIce"
        case drinkSugar = "drinkSugar"
        case addPearl = "addPearl"
        case drinkPrice = "drinkPrice"
    }
}

struct OrderDrinkData: Codable {
       var data: [OrderDrinkModel]
   }
