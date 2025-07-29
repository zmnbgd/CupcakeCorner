//
//  CheckoutView.swift
//  Cupcake Corner
//
//  Created by Marko Zivanovic on 25. 7. 2025..
//

import SwiftUI

struct CheckoutView: View {
    
    var order: Order
    
    @State private var confirmaionMessage = ""
    @State private var showingConfirmation = false
    
    
    
    
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"),
                           scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total cost is \(order.cost, format: .currency(code: "EUR"))")
                    .font(.title2)
                
                //MARK: - Button action Empty closure for now
                Button("Place order") {
                    Task {
                        await placeOrder()
                    }
                }
                    .padding()
                    
            }
        }
        .navigationTitle("Chect out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you", isPresented: $showingConfirmation) {
            Button("Ok") {}
        } message: {
            Text(confirmaionMessage)
        }
    }
    
    func placeOrder() async {
        //MARK: - Converting our object into JSON data
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        //MARK: - Tell Swift how to send that over internet
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue( "application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        do {
            //MARK: Run request and process response
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            //MARK: - Handle result here
            //MARK: - Commented code did not work 
            //let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            //confirmaionMessage = "Your order \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on it's way!"
            confirmaionMessage = "Your order \(order.quantity)x \(Order.types[order.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}

//MARK: - p String(decoding: encoded, as: UTF8.self)
