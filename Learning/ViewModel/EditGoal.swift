//
//  EditGoal.swift
//  Learning
//
//  Created by Shahad Almashjari on 16/11/2026.
//

import Foundation
import Observation

@Observable
class EditGoal {
    var topic: String
    var duration: Duration
    var showUpdateAlert = false

    private let onUpdate: (String, Duration) -> Void

    init(topic: String, duration: Duration,
         onUpdate: @escaping (String, Duration) -> Void) {
        self.topic = topic
        self.duration = duration
        self.onUpdate = onUpdate
    }

    var canSave: Bool {
        !topic.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func askToUpdate() {
        showUpdateAlert = true
    }

    func confirmUpdate() {
        onUpdate(topic.trimmingCharacters(in: .whitespacesAndNewlines), duration)
    }
}
