//
//  DrinkModel.swift
//  OrderDrink
//
//  Created by Una Lee on 2020/8/13.
//  Copyright © 2020 una.lee. All rights reserved.
//

import Foundation

struct DrinkModel: Codable {
    var drinkNumber: String
    var drinkName: String
    var mediumPrice: String
    var largePrice: String
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case drinkNumber = "drinkNumber"
        case drinkName = "drinkName"
        case mediumPrice = "mediumPrice"
        case largePrice = "largePrice"
        case description = "description"
    }
}
