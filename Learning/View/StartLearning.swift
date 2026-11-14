//
//  StartLearning.swift
//  Learning
//
//  Created by Shahad Almashjari on 10/11/2026.
//

import SwiftUI

struct Learning: View {
    @State private var viewModel = LearningGoal()

    var body: some View {
        VStack {
        
            VStack(alignment: .leading, spacing: 24) {
                Image(systemName: "flame.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(.orange)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 40)

                header
                topicField
                durationPicker

                Spacer()

                startButton
            }
            .padding(.horizontal, 16)
        }
        .navigationDestination(isPresented: $viewModel.isStarted) {
            LogInDay(topic: viewModel.topic, duration: viewModel.duration)
    }
    
        }

    // MARK: -

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Hello **Learner**")
                .font(.largeTitle)
               

            Text("This app will help you learn everyday!")
                .foregroundStyle(.gray)
        }
        .padding(.top, 40)
    }

    private var topicField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("I want to learn")

            TextField("Inter a goal", text: $viewModel.topic)

            Divider()
            
            if let message = viewModel.errorMessage {
                        Text(message)
                            .font(.caption)
                            .foregroundStyle(.red)
                    }
        }
    }

    private var durationPicker: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("I want to learn it in a")

            HStack(spacing: 12) {
                ForEach(Duration.allCases, id: \.self) { item in
                    Button(item.rawValue) {
                        viewModel.duration = item
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .foregroundStyle(viewModel.duration == item ? .white : .gray)
                    .background(
                        viewModel.duration == item ? Color.orange : Color.white.opacity(0.1),
                        in: Capsule()
                    )
                }
            }
        }
    }

    private var startButton: some View {
        VStack(spacing: 8) {
            Button("Start Learning") {
                viewModel.startLearning()
                // go to the next screen
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 32)
            .padding(.vertical, 12)
            .foregroundStyle(.white)
            .background(Capsule().fill(Color.orange))

            Text("You can edit your desire later")
                .font(.caption)
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 16)
    }
}

#Preview {
    NavigationStack {
        Learning()
    }
}
