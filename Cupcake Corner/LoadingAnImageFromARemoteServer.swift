//
//  LoadingAnImageFromARemoteServer.swift
//  Cupcake Corner
//
//  Created by Marko Zivanovic on 20. 7. 2025..
//

import SwiftUI

struct LoadingAnImageFromARemoteServer: View {
    var body: some View {
        //MARK: - First
        //        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3)
        
        // MARK: - Second
        //        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
        //            image
        //                .resizable()
        //                .scaledToFit()
        //        } placeholder: {
        //            //Color.red
        //            ProgressView()
        //        }
        //        .frame(width: 200, height: 200)
        
        // MARK: - Trhird
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    LoadingAnImageFromARemoteServer()
}
