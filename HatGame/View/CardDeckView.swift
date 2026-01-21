//
//  CardDeckView.swift
//  HatGame
//
//  Created by Stoyan Hristov on 3.01.26.
//

import SwiftUI

struct CardDeckView: View {
    @State private var words = ["Kaiba", "Yugi", "Joey", "Pegasus", "Bakura"]

    var body: some View {
        
        ZStack {
            ForEach(Array(words.enumerated()), id: \.element) { index, word in
                // The card is the "top card" if its index is the last one in the array
                let isTopCard = index == words.count - 1
                
                SwipeCardView(
                    word: word,
                    isBlurred: !isTopCard, // Blur if it's NOT the top card
                    onSwipe: { _ in
                        removeCard()
                    }
                )
                // Slight vertical offset for the cards behind to look like a deck
                .offset(y: isTopCard ? 0 : -10)
                .zIndex(Double(index))
            }
            
            if words.isEmpty {
                ContentUnavailableView("Няма повече карти", systemImage: "square.stack.3d.up.slash")
                    .foregroundStyle(.white)
                    .border(.blue)
            }
        }
    }

    private func removeCard() {
        withAnimation {
            if !words.isEmpty {
                words.removeLast()
            }
        }
    }
}

#Preview {
    ZStack {
        // Background color to see the blur effect better
        LinearGradient(colors: [.black.opacity(0.8), .black], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
        CardDeckView()
    }
}
