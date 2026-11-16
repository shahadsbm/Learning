//
//  EditGoalV.swift
//  Learning
//
//  Created by Shahad Almashjari on 16/11/2026.
//

import SwiftUI

struct EditGoalView: View {
    @State private var viewModel: EditGoal
    @Environment(\.dismiss) private var dismiss

    init(topic: String, duration: Duration,
         onUpdate: @escaping (String, Duration) -> Void) {
        _viewModel = State(initialValue: EditGoal(
            topic: topic, duration: duration, onUpdate: onUpdate))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            topBar
            topicField
            durationPicker

            Spacer()
        }
        .padding(.horizontal, 16)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .tint(.orange)
        .alert("Update goal", isPresented: $viewModel.showUpdateAlert) {
            Button("Dismiss", role: .cancel) { }
            Button("Update") { viewModel.confirmUpdate() }
        } message: {
            Text("If you update now, your streak will start over.")
        }
    }

    // MARK: - Sections

    private var topBar: some View {
        ZStack {
            Text("Learning Goal")
                .font(.headline)

            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .frame(width: 44, height: 44)
                        .background(Color.white.opacity(0.1), in: Circle())
                }
                .buttonStyle(.plain)

                Spacer()

                Button {
                    viewModel.askToUpdate()
                } label: {
                    Image(systemName: "checkmark")
                        .font(.title3.bold())
                        .frame(width: 44, height: 44)
                        .background(Color.orange, in: Circle())
                }
                .buttonStyle(.plain)
                .disabled(!viewModel.canSave)
            }
        }
        .foregroundStyle(.white)
    }

    private var topicField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("I want to learn")

            TextField("Enter a goal", text: $viewModel.topic)

            Divider()
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
}

#Preview {
    NavigationStack {
        EditGoalView(topic: "Swift", duration: .week) { _, _ in }
    }
}
