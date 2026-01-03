//
//  ContentView.swift
//  HatGame
//
//  Created by Stoyan Hristov on 1.01.26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var teamsCount: Int = 5
    @State private var wordsDifficultyLevel: Words.Level = .medium
    @State private var showTeamSelectionScreen: Bool = true
    @State private var game: Game?
    var body: some View {
        
        NavigationStack {
            VStack {
                SwipeCardView(word: "Yugi", isBlurred: false) { _ in }
                
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
            .navigationDestination(isPresented: $showTeamSelectionScreen) {
                TeamSetupView(selectedCountOfTeams: $teamsCount, difficultyLevel: $wordsDifficultyLevel)
        }
        
        }
        .onChange(of: showTeamSelectionScreen) { _, isSetupScreenDisplayed in
            
        }
    }
    private func initGame() {
        let teams = (1...teamsCount).map { Team(name: "Отбор \($0)", score: 0) }
        game = Game(teams: teams, currentTurnSkipCount: 0, leftTimePerTurn: 60, difficulty: wordsDifficultyLevel)
    }
}


#Preview {
    ContentView()
}
