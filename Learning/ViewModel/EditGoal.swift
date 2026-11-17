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

struct GoalStore {
    private let key = "savedGoal"

    func load() -> SavedGoal? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(SavedGoal.self, from: data)
    }

    func save(_ goal: SavedGoal) {
        guard let data = try? JSONEncoder().encode(goal) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }
}


