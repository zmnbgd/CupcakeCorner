//
//  Order.swift
//  Cupcake Corner
//
//  Created by Marko Zivanovic on 24. 7. 2025..
//

import Foundation

@Observable

class Order: Codable {
    
    //MARK: - Challenge 3., Cupcake Corner: For a more challenging task, try updating the Order class so it saves data such as the user's delivery address to UserDefaults. This takes a little thinking, because @AppStorage won't work here, and you'll find getters and setters cause problems with Codable support. Can you find a middle ground?
    private static let userDefaultsKey = "SavedOrder"

    init() {
        load()
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encoded, forKey: Self.userDefaultsKey)
        }
    }
    
    func load() {
        guard let data = UserDefaults.standard.data(forKey: Self.userDefaultsKey),
              let decoded = try? JSONDecoder().decode(Order.self, from: data) else { return }
        
        self.type = decoded.type
        self.quantity = decoded.quantity
        self.specialRequestEnabled = decoded.specialRequestEnabled
        self.extraFrosting = decoded.extraFrosting
        self.addSprinkles = decoded.addSprinkles
        self.name = decoded.name
        self.streetAddress = decoded.streetAddress
        self.city = decoded.city
        self.zip = decoded.zip
    }
    
    
    
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
    
//    var hasValidAddress: Bool {
//        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
//            return false
//        }
//        return true
//    }
    //MARK: - Challenge 1., Project Cupcake Corner: Our address fields are currently considered valid if they contain anything, even if it’s just only whitespace. Improve the validation to make sure a string of pure whitespace is invalid.
    //MARK: Comment: The condition is intentionally written to cover all fields of the user placing the order.
    var isShippingInfoValid: Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
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
