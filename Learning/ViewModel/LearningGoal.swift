//
//  LearningGoal.swift
//  Learning
//
//  Created by Shahad Almashjari on 12/11/2026.
//

import Observation
import Foundation

@Observable
class LearningGoal {
    var topic: String = ""
    var duration: Duration = .week   // Week is selected by default
    var didTryToStart = false
    var isStarted = false

    var canStart: Bool {
        !topic.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var errorMessage: String? {
        (didTryToStart && !canStart) ? "Please enter a goal" : nil
    }

    func startLearning() {
        didTryToStart = true
        if canStart {
            isStarted = true
        }
    }
}
