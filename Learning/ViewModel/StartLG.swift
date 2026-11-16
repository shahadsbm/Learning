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
    var goalStartDate: Date         // renamed from streakStartDate
    var now: Date = Date()                          // NEW: the app's "current time"
    var isEditingGoal = false


    init(topic: String, duration: Duration) {
        let start = Date()
        self.topic = topic
        self.duration = duration
        self.now = start
        self.goalStartDate = start
        
    }

    private let maxGap: TimeInterval = 32 * 60 * 60   // 32 hours in seconds
    private let calendar = Calendar.current

    // MARK: - Computed (worked out from the facts)
    var freezeLimit: Int {
        duration.freezeLimit
    }

    private var streakEntries: [DayEntry] {
        let relevant = entries
            .filter { $0.date >= goalStartDate }
            .sorted { $0.date > $1.date }

        guard let latest = relevant.first,
              now.timeIntervalSince(latest.date) <= maxGap else { return [] }

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
        entries.filter { $0.status == .learned && $0.date >= goalStartDate }.count
    }

    var frozenCount: Int {
        entries.filter { $0.status == .frozen && $0.date >= goalStartDate }.count
    }

    var freezeText: String {
        "\(frozenCount) out of \(freezeLimit) Freezes used"
    }

    private var todayEntry: DayEntry? {             // NEW: the one shared check
        entries.last {
            calendar.isDate($0.date, inSameDayAs: now) && $0.date >= goalStartDate
        }
    }

    var isTodayLogged: Bool {
        todayEntry != nil
    }

    var isTodayFrozen: Bool {
        todayEntry?.status == .frozen
    }

    var isTodayLearned: Bool {
        todayEntry?.status == .learned
    }

    var dateText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM"      // Thursday, 24 October
        return formatter.string(from: now)
    }

    var canFreeze: Bool {
        !isGoalFinished && !isTodayFrozen && frozenCount < freezeLimit
    }

    var canLog: Bool {
        !isGoalFinished && !isTodayLearned
    }
    
    private var goalEndDate: Date {
        let firstDay = calendar.startOfDay(for: goalStartDate)
        return calendar.date(byAdding: .day, value: duration.days, to: firstDay) ?? .distantFuture
    }

    var isGoalFinished: Bool {
        now >= goalEndDate
    }

    private var loggedDayCount: Int {
        Set(
            entries
                .filter { $0.date >= goalStartDate && $0.date < goalEndDate }
                .map { calendar.startOfDay(for: $0.date) }
        ).count
    }

    var goalResult: GoalResult? {
        guard isGoalFinished else { return nil }
        return loggedDayCount == duration.days ? .completed : .failed
    }

    // MARK: - Actions
    func logAsLearned() {
        refreshDate()                               // NEW
        guard canLog else { return }
        setToday(.learned)
    }

    func freezeToday() {
        refreshDate()                               // NEW
        guard canFreeze else { return }
        setToday(.frozen)
    }

    func updateGoal(topic: String, duration: Duration) {
        refreshDate()
        self.topic = topic
        self.duration = duration
        goalStartDate = now                  // counts and streak start over
        isEditingGoal = false                // closes the edit screen
    }

    func refreshDate() {                            // NEW
        now = Date()
    }
    
    func editGoal() {
        isEditingGoal = true
    }

    // MARK: - Helper
    private func entry(for date: Date) -> DayEntry? {
        entries.first { calendar.isDate($0.date, inSameDayAs: date) }
    }

    private func setToday(_ status: DayStatus) {
        entries.removeAll {
            calendar.isDate($0.date, inSameDayAs: now) && $0.date >= goalStartDate
        }
        entries.append(DayEntry(date: now, status: status))
    }

    var weekDays: [WeekDay] {
        var cal = calendar
        cal.firstWeekday = 1                        // Sunday first, like your design

        guard let weekStart = cal.dateInterval(of: .weekOfYear, for: now)?.start
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
                isToday: cal.isDate(date, inSameDayAs: now)   // CHANGED
            )
        }
    }
}
