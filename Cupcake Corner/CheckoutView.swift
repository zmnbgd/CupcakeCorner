//
//  CheckoutView.swift
//  Cupcake Corner
//
//  Created by Marko Zivanovic on 25. 7. 2025..
//

import SwiftUI

struct CheckoutView: View {
    
    var order: Order
    
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
                Button("Place order", action: {})
                    .padding()
                    
            }
        }
        .navigationTitle("Chect out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    CheckoutView(order: Order())
}
