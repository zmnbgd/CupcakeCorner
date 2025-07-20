//
//  SendingAndReceivingCodableDataWithURLSessionAndSwiftUI.swift
//  Cupcake Corner
//
//  Created by Marko Zivanovic on 18. 7. 2025..
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct SendingAndReceivingCodableDataWithURLSessionAndSwiftUI: View {
    
    @State private var results = [Result]()
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        // MARK: - First create URL we want to read from Apple servers
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        //MARK: - Second fetch data from that URL
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            //MARK: - Third decode that result into a response struct (struct Response: Codable)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data)
            {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid data")
        }
    }
}

#Preview {
    SendingAndReceivingCodableDataWithURLSessionAndSwiftUI()
}
