//
//  Order.swift
//  Cupcake Corner
//
//  Created by Marko Zivanovic on 24. 7. 2025..
//

import Foundation

@Observable

class Order {
    static let types = ["Vanilla", "Chocolate", "Strawberry", "Red Velvet", "Carrot Cake", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
    didSet {
        if specialRequestEnabled == false {
            extraFrosting = false
            addSprinkles = false
        }
    }
}
    var extraFrosting = false
    var addSprinkles = false
    
}
