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
        
        VStack(alignment: .leading, spacing: 24) {
            Image(systemName: "flame.fill")
                .font(.system(size: 40))
                .foregroundStyle(.orange)
                .frame(maxWidth: .infinity)
                .padding(.top, 40)
            
            header
            TopicField(topic: $viewModel.topic, errorMessage: viewModel.errorMessage)
            DurationPicker(selection: $viewModel.duration)
            
            Spacer()
            
            startButton
        }
        
        .padding(.horizontal, 16)
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
    
    private var startButton: some View {
        VStack(spacing: 8) {
            Button("Start Learning") {
                viewModel.startLearning()
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
