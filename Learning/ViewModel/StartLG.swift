//
//  StartLG.swift
//  Learning
//
//  Created by Shahad Almashjari on 14/11/2026.
//

import Foundation
import Observation

@Observable
class StartLG {

    // MARK: - Stored (the original facts)
    var entries: [DayEntry] = []
    var topic: String = ""
    var duration: Duration = .week
    var streakStartDate: Date = .distantPast
    init(topic: String, duration: Duration) {
        self.topic = topic
        self.duration = duration
    }

    private let maxGap: TimeInterval = 32 * 60 * 60   // 32 hours in seconds
    private let calendar = Calendar.current

    // MARK: - Computed (worked out from the facts)
    var freezeLimit: Int {
        duration.freezeLimit
    }

    private var streakEntries: [DayEntry] {
        let relevant = entries
            .filter { $0.date >= streakStartDate }
            .sorted { $0.date > $1.date }

        guard let latest = relevant.first,
              Date().timeIntervalSince(latest.date) <= maxGap else { return [] }

        var result = [latest]
        for (newer, older) in zip(relevant, relevant.dropFirst()) {
            guard newer.date.timeIntervalSince(older.date) <= maxGap else { break }
            result.append(older)
        }
        return result
    }

    var streak: Int {
        streakEntries.count
    }

    var learnedCount: Int {
        entries.filter { $0.status == .learned && $0.date >= streakStartDate }.count
    }

    var frozenCount: Int {
        entries.filter { $0.status == .frozen && $0.date >= streakStartDate }.count
    }

    var freezeText: String {
        "\(frozenCount) out of \(freezeLimit) Freezes used"
    }
   
    var isTodayLogged: Bool {
        entries.contains {
            calendar.isDate($0.date, inSameDayAs: Date()) && $0.date >= streakStartDate
        }
    }
    var isTodayFrozen: Bool {
        entries.contains {
            $0.status == .frozen
            && calendar.isDate($0.date, inSameDayAs: Date())
            && $0.date >= streakStartDate
        }
    }
    var isTodayLearned: Bool {
        entries.contains {
            $0.status == .learned
            && calendar.isDate($0.date, inSameDayAs: Date())
            && $0.date >= streakStartDate
        }
    }
    var dateText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM"      // Thursday, 24 October
        return formatter.string(from: Date())
    }

    var canFreeze: Bool {
        !isTodayLogged && frozenCount < freezeLimit
    }

    // MARK: - Actions
    func logAsLearned() {
        guard !isTodayLogged else { return }
        entries.append(DayEntry(date: Date(), status: .learned))
    }

    func freezeToday() {
        guard canFreeze else { return }
        entries.append(DayEntry(date: Date(), status: .frozen))
    }

    func updateGoal(topic: String, duration: Duration) {
        self.topic = topic
        self.duration = duration
        streakStartDate = Date()                   // streak starts over
    }

    // MARK: - Helper
    private func entry(for date: Date) -> DayEntry? {
        entries.first { calendar.isDate($0.date, inSameDayAs: date) }
    }
    
    var weekDays: [WeekDay] {
        var cal = calendar
        cal.firstWeekday = 1                        // Sunday first, like your design

        guard let weekStart = cal.dateInterval(of: .weekOfYear, for: Date())?.start
        else { return [] }

        return (0..<7).compactMap { offset in
            guard let date = cal.date(byAdding: .day, value: offset, to: weekStart)
            else { return nil }

            let status = entries
                .filter { cal.isDate($0.date, inSameDayAs: date) }
                .max { $0.date < $1.date }?.status   // latest entry of that day

            return WeekDay(
                date: date,
                letter: cal.veryShortWeekdaySymbols[cal.component(.weekday, from: date) - 1],
                number: cal.component(.day, from: date),
                status: status,
                isToday: cal.isDateInToday(date)
            )
        }
    }
}
