//
//  ValidatingAndDisablingForms.swift
//  Cupcake Corner
//
//  Created by Marko Zivanovic on 21. 7. 2025..
//

import SwiftUI

struct ValidatingAndDisablingForms: View {
    
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            Section {
                Button("Create account") {
                    Text("Creating account...")
                }
            }
            //.disabled(username.isEmpty || email.isEmpty)
            .disabled(disableForm)
        }
    }
}

#Preview {
    ValidatingAndDisablingForms()
}
