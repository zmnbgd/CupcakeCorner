//
//  AddressView.swift
//  Cupcake Corner
//
//  Created by Marko Zivanovic on 24. 7. 2025..
//

import SwiftUI

struct AddressView: View {
    
    @Bindable var order: Order
    
    var body: some View {
        Form {
            
            Section {
                TextField("Name", text: $order.name)
                TextField("Street", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip code", text: $order.zip)
            }
            
            Section {
                NavigationLink("Checkout") {
                    CheckoutView(order: order)
                }
            }
            //MARK: - Challenge 1., Project Cupcake Corner
            //.disabled(order.hasValidAddress == false)
            .disabled(order.isShippingInfoValid == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order())
}
