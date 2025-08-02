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
        
        //MARK: - Challenge 3., Cupcake Corner: Every time the user enters something in one of the fields (name, street, city, zip), order.save() is called immediately and the data is saved in UserDefaults.
        .onChange(of: order.name) { order.save() }
        .onChange(of: order.streetAddress) { order.save() }
        .onChange(of: order.city) { order.save() }
        .onChange(of: order.zip) { order.save() }
        
        //MARK: - Challenge 3., Cupcake Corner: onDisappear to save the data when the user exits the AddressView
        .onDisappear() {
            order.save()
        }
    }
}

#Preview {
    AddressView(order: Order())
}
