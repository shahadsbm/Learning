//
//  SavedGoal.swift
//  Learning
//
//  Created by Shahad Almashjari on 16/11/2026.
//

import Foundation

struct SavedGoal: Codable {
    var topic: String
    var duration: Duration
    var goalStartDate: Date
    var entries: [DayEntry]
}
