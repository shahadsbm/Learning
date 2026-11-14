//
//  DayEntry.swift
//  Learning
//
//  Created by Shahad Almashjari on 14/11/2026.
//

import Foundation

enum DayStatus {
    case learned
    case frozen
}

struct DayEntry: Identifiable {
    let id = UUID()
    let date: Date
    let status: DayStatus
}

struct WeekDay: Identifiable {
    let date: Date
    let letter: String       // "S", "M", ...
    let number: Int          // 20, 21, ...
    let status: DayStatus?   // nil = nothing logged that day
    let isToday: Bool

    var id: Date { date }
}
