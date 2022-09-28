//
//  File.swift
//  Guess by emoji
//
//  Created by Kurbatov Artem on 06.04.2022.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        TabView {
            
            ContentView()
                .tabItem {
                    VStack {
                        Image(systemName: "play.circle")
                        Text("Play")
                    }
                }
            
            ResultView()
                .tabItem {
                    VStack {
                        Image(systemName: "line.3.horizontal.circle.fill")
                        Text("Results")
                    }
                }
        }
    }
}
