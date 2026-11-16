//
//  Activities.swift
//  Learning
//
//  Created by Shahad Almashjari on 16/11/2026.
//

import Foundation
import Observation

@Observable
class Activities {
    private let entries: [DayEntry]
    private let today: Date
    private let calendar: Calendar

    init(entries: [DayEntry], today: Date) {
        var cal = Calendar.current
        cal.firstWeekday = 1                          // Sunday first, like the design
        self.calendar = cal
        self.entries = entries
        self.today = today
    }

    var weekdayHeaders: [String] {
        calendar.shortWeekdaySymbols.map { $0.uppercased() }     // SUN MON ...
    }

    var months: [CalendarMonth] {
        let currentMonth = startOfMonth(for: today)
        let firstMonth = entries.map(\.date).min().map { startOfMonth(for: $0) } ?? currentMonth

        var result: [CalendarMonth] = []
        var monthStart = firstMonth
        while monthStart <= currentMonth {
            result.append(makeMonth(startingAt: monthStart))
            guard let next = calendar.date(byAdding: .month, value: 1, to: monthStart)
            else { break }
            monthStart = next
        }
        return result
    }

    // MARK: - Helpers
    private func startOfMonth(for date: Date) -> Date {
        calendar.dateInterval(of: .month, for: date)?.start ?? date
    }

    private func makeMonth(startingAt monthStart: Date) -> CalendarMonth {
        let dayCount = calendar.range(of: .day, in: .month, for: monthStart)?.count ?? 30

        let days = (0..<dayCount).compactMap { offset -> CalendarDay? in
            guard let date = calendar.date(byAdding: .day, value: offset, to: monthStart)
            else { return nil }

            return CalendarDay(
                date: date,
                number: offset + 1,
                status: status(on: date),
                isToday: calendar.isDate(date, inSameDayAs: today)
            )
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"            // January 2026

        return CalendarMonth(
            start: monthStart,
            title: formatter.string(from: monthStart),
            leadingBlanks: calendar.component(.weekday, from: monthStart) - 1,
            days: days
        )
    }

    private func status(on date: Date) -> DayStatus? {
        entries
            .filter { calendar.isDate($0.date, inSameDayAs: date) }
            .max { $0.date < $1.date }?.status         // latest entry of that day
    }
}
