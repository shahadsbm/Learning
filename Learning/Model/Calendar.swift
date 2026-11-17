//
//  Calendar.swift
//  Learning
//
//  Created by Shahad Almashjari on 16/11/2026.
//

import Foundation

struct CalendarDay: Identifiable {
    let date: Date
    let number: Int
    let status: DayStatus?       // nil = nothing logged
    let isToday: Bool

    var id: Date { date }
}

struct CalendarMonth: Identifiable {
    let start: Date
    let title: String            
    let leadingBlanks: Int       // empty cells before the 1st
    let days: [CalendarDay]

    var id: Date { start }
}
