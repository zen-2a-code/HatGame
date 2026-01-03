//
//  TeamSetupView.swift
//  HatGame
//
//  Created by Stoyan Hristov on 1.01.26.
//

import SwiftUI

struct TeamSetupView: View {
    @Binding var selectedCountOfTeams: Int
    @Binding var difficultyLevel: Words.Level
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.mint, .blue], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack (spacing: 30) {
                    Spacer()
                VStack (spacing: 20){
                    Text("Трудност на думите")
                        .font(.title2)
                        .foregroundStyle(.white)
                    
                    Picker("Трудност на думите", selection: $difficultyLevel) {
                        ForEach(Words.Level.allCases) { level in
                            Text(level.rawValue)
                                .fontWeight(.semibold)
                                .tag(level)
                        }
                    }
                    .pickerStyle(.segmented)
                    .colorScheme(.dark)
                    .foregroundStyle(.white)
                }
                    
                    Text("Моля изберете брой отбори")
                        .font(.title2)
                        .foregroundStyle(.white)

                    Picker("Брой играчи", selection: $selectedCountOfTeams) {
                        ForEach(2 ..< 11, id: \.self) { number in
                            Text("\(number)").tag(number)
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                        }
                    }
                    .pickerStyle(.wheel)
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Готово") { dismiss() }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}
#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    @State private var selectedCountOfTeams = 5
    @State private var difficultyLevel: Words.Level = .easy

    var body: some View {
        TeamSetupView(
            selectedCountOfTeams: $selectedCountOfTeams,
            difficultyLevel: $difficultyLevel
        )
    }
}
