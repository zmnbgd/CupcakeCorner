//
//  Order.swift
//  Cupcake Corner
//
//  Created by Marko Zivanovic on 24. 7. 2025..
//

import Foundation

@Observable

class Order: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _streetAddress = "streetAddress"
        case _city = "city"
        case _zip = "zip"
    }
    
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
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
    
    var cost: Decimal {
        //MARK: - 2$ per cake
        var cost = Decimal(quantity) * 2
        
        //MARK: - Complicated cakes cost more
        cost += Decimal(type) / 2
        
        //MARK: - 1$ per cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        //MARK: - 0.50$ per cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        return cost
    }
}
