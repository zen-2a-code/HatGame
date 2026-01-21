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
    @State private var offset: CGSize = .zero
    private let gradient: LinearGradient
    let word: String
    
    // 1. Add a callback to notify the parent deck
    var onSwipe: (Bool) -> Void // True for right, false for left
    
    // 2. Add a property to control the blur from the outside
    var isBlurred: Bool = false

    private let swipeThreshold: CGFloat = 120

    init(word: String, isBlurred: Bool = false, onSwipe: @escaping (Bool) -> Void) {
        self.word = word
        self.isBlurred = isBlurred
        self.onSwipe = onSwipe
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
                    // Apply blur ONLY to the content if specified
                    .blur(radius: isBlurred ? 10 : 0)
            )
            .frame(width: 350, height: 500)
            .offset(offset)
            .rotationEffect(.degrees(Double(offset.width / 15)))
            // Optional: Subtle scale effect for blurred cards
            .scaleEffect(isBlurred ? 0.95 : 1.0)
            .gesture(
                // Disable drag if the card is blurred (background card)
                isBlurred ? nil : DragGesture()
                    .onChanged { value in
                        offset = value.translation
                    }
                    .onEnded { _ in
                        handleSwipe()
                    }
            )
            .animation(.spring(), value: offset)
            .animation(.default, value: isBlurred)
    }

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
        // Notify parent after animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            onSwipe(true)
        }
    }

    private func swipeLeft() {
        offset = CGSize(width: -1000, height: 0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            onSwipe(false)
        }
    }
    
    // ... (Keep your randomGradient function here)
    private static func randomGradient() -> LinearGradient {
        let palettes: [[Color]] = [[.pink, .orange], [.purple, .blue], [.teal, .green]]
        let colors = palettes.randomElement() ?? [.blue, .purple]
        return LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}


#Preview("Active Card") {
    ZStack {
        Color.black.ignoresSafeArea() // Background to show glass effect
        SwipeCardView(word: "Kaiba", isBlurred: false) { isRightSwipe in
            print("Swiped: \(isRightSwipe ? "Right" : "Left")")
        }
    }
}

#Preview("Blurred Card") {
    ZStack {
        Color.black.ignoresSafeArea()
        SwipeCardView(word: "Yugi", isBlurred: true) { _ in }
    }
}

