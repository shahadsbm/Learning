//
//  GoalStore.swift
//  Learning
//
//  Created by Shahad Almashjari on 16/11/2026.
//

import Foundation
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
