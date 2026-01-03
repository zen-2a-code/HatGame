//
//  TeamSetupView.swift
//  HatGame
//
//  Created by Stoyan Hristov on 1.01.26.
//

import SwiftUI

struct TeamSetupView: View {
    @Binding var selectedCountOfTeams: Int
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.purple, .blue], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
//                    Text("Трудност на думите")
//                        .font(.title2)
//                        .foregroundStyle(.white)
//
//                    Picker("Брой играчи", selection: $selectedCountOfTeams) {
//                        ForEach(Words.level.allCases, id: \.self) { number in
//                            Text("\(number)").tag(number)
//                                .foregroundStyle(.white)
//                                .fontWeight(.semibold)
//                        }
//                    }
//                    .pickerStyle(.wheel)
//                    .tint(.white)
                    
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
    TeamSetupView(selectedCountOfTeams: .constant(2))
}
