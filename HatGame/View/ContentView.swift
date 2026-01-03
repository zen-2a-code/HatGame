//
//  ContentView.swift
//  HatGame
//
//  Created by Stoyan Hristov on 1.01.26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var teamsCount: Int = 2
    @State private var showTeamSelectionScreen: Bool = true
    var body: some View {
        
        NavigationStack {
            VStack {
                SwipeCardView(word: "Кайба")
                
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
            .navigationDestination(isPresented: $showTeamSelectionScreen) {
                TeamSetupView(selectedCountOfTeams: $teamsCount)
        }
        
        }
    }
}

#Preview {
    ContentView()
}
