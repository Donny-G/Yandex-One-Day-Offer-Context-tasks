//
//  ContentView.swift
//  AnonAPITask
//
//  Created by DeNNiO   G on 07.06.2021.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        TabView {
            AllPagesView(type: .showAll, anoFeed: AnonDataFetcher(url: Endpoint.noFilter.url))
                .tabItem {
                    Image(systemName: "binoculars.fill")
                    Text("All")
                }
            
            AllPagesView(type: .mostPopular, anoFeed: AnonDataFetcher(url: Endpoint.mostPopular.url))
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Most Popular")
                }
            
            AllPagesView(type: .mostCommented, anoFeed: AnonDataFetcher(url: Endpoint.mostCommented.url))
                .tabItem {
                    Image(systemName: "text.bubble.fill")
                    Text("Most Commented")
                }
            
            AllPagesView(type: .createdAt, anoFeed: AnonDataFetcher(url: Endpoint.createdAt.url))
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Created At")
                }
        }
        .accentColor(.black)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

