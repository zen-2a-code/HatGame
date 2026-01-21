//
//  TimerView.swift
//  HatGame
//
//  Created by Stoyan Hristov on 21.01.26.
//

import SwiftUI
internal import Combine

struct TimerView: View {
    @State private var secondsLeft = 60
    @State private var isRunning = false
    @State private var timerConnection: Cancellable? = nil
    @Binding var shouldStartTimer: Bool
    var onTimerFinished: () -> Void
    var timer = Timer.publish(every: 1, on: .main, in: .common)

    var body: some View {
        VStack {
            HStack(spacing: 0){
                Label("Оставащо време: ", systemImage: "timer")
                    .font(.title2)
                
                Text("\(secondsLeft)")
                    .font(.title2)
                    .contentTransition(.numericText())
                    .animation(.default, value: secondsLeft)
            }
                
        }
        .onReceive(timer) { _ in
            guard isRunning else { return }
            guard secondsLeft > 0 else {
                stopTimer()
                onTimerFinished()
                return
            }
            secondsLeft -= 1
        }
        .onChange(of: shouldStartTimer) { _, newValue in
            if newValue {
                startTimer()
            }
        }
    }

    private func startTimer() {
        isRunning = true
        timerConnection = timer.connect()
    }

    private func stopTimer() {
        isRunning = false

        timerConnection?.cancel()
        timerConnection = nil
    }
}

#Preview {
    TimerViewPreviewWrapper()
}

struct TimerViewPreviewWrapper: View {
    @State private var shouldStartTimer = false

    var body: some View {
        VStack(spacing: 20) {

           TimerView(shouldStartTimer: $shouldStartTimer, onTimerFinished: {})

            Button("Start Timer") {
                shouldStartTimer = true
            }

            Button("Stop Timer") {
                shouldStartTimer = false
            }
        }
        .padding()
    }
}
