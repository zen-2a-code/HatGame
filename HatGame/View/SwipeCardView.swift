//
//  SwipeCardView.swift
//  HatGame
//
//  Created by Stoyan Hristov on 1.01.26.
//
import SwiftUI

/**
 A single swipeable card.
 Supports left / right swipe with animation.
 Each card gets a random beautiful gradient background.
 */
struct SwipeCardView: View {

    /// Current drag offset
    @State private var offset: CGSize = .zero

    /// Random gradient for this card (created once)
    private let gradient: LinearGradient

    let word: String

    /// Swipe decision threshold
    private let swipeThreshold: CGFloat = 120

    init(word: String) {
        self.word = word
        self.gradient = SwipeCardView.randomGradient()
    }

    var body: some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(gradient)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .fill(.ultraThinMaterial)
            )
            .overlay(
                Text(word)
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.center)
                    .padding()
            )
            .frame(width: 300, height: 420)
            .offset(offset)
            .rotationEffect(.degrees(Double(offset.width / 15)))
            .gesture(
                DragGesture()
                    .onChanged { value in
                        offset = value.translation
                    }
                    .onEnded { _ in
                        handleSwipe()
                    }
            )
            .animation(.spring(), value: offset)
    }

    /**
     Decides whether the card is liked, disliked, or snapped back.
     */
    private func handleSwipe() {
        if offset.width > swipeThreshold {
            swipeRight()
        } else if offset.width < -swipeThreshold {
            swipeLeft()
        } else {
            offset = .zero
        }
    }

    private func swipeRight() {
        offset = CGSize(width: 1000, height: 0)
        // TODO: notify parent (liked)
    }

    private func swipeLeft() {
        offset = CGSize(width: -1000, height: 0)
        // TODO: notify parent (disliked)
    }

    // MARK: - Gradient factory

    /**
     Generates a visually pleasing random gradient.
     */
    private static func randomGradient() -> LinearGradient {
        let palettes: [[Color]] = [
            [.pink, .orange],
            [.purple, .blue],
            [.teal, .green],
            [.indigo, .cyan],
            [.red, .yellow],
            [.mint, .blue],
            [.purple, .pink]
        ]

        let colors = palettes.randomElement() ?? [.blue, .purple]

        return LinearGradient(
            colors: colors,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}


#Preview {
    SwipeCardView(word: "Kaiba")
}

#Preview {
    SwipeCardView(word: "Kaiba")
}

#Preview {
    SwipeCardView(word: "Kaiba")
}

