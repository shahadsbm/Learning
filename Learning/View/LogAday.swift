//
//  LogAday.swift
//  Learning
//
//  Created by Shahad Almashjari on 14/11/2026.
//

import SwiftUI

struct LogInDay : View {
    
    
    @State private var viewModel: StartLG
    @Environment(\.scenePhase) private var scenePhase
    
    init(topic: String, duration: Duration) {
        _viewModel = State(initialValue: StartLG(topic: topic, duration: duration))
        
    }
    
    init(saved: SavedGoal) {
        _viewModel = State(initialValue: StartLG(saved: saved))
    }
    var body: some View {
        VStack {
            topBar
            dateHeader
            weekStrip
            statsRow
            
            Spacer()
            
            if let result = viewModel.goalResult {
                   resultArea(for: result)
                   Spacer()
            } else {
                logArea
            }
                
        }
        .padding(.horizontal, 16)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .active {
                viewModel.refreshDate()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .NSCalendarDayChanged)) { _ in
            viewModel.refreshDate()
        }
        .navigationDestination(isPresented: $viewModel.isEditingGoal) {
            EditGoalView(topic: viewModel.topic, duration: viewModel.duration) { topic, duration in
                viewModel.updateGoal(topic: topic, duration: duration)
            }
        }
        .navigationDestination(isPresented: $viewModel.isShowingCalendar) {
            ActivitiesView(entries: viewModel.entries, today: viewModel.now)
        }
        
    }
    
    // MARK: - Sections
    
    private var topBar: some View {
        HStack(spacing: 12) {
            Text("Activity")
                .font(.largeTitle)
                .bold()
            
            Spacer()
            
            Button {
                viewModel.openCalendar()
            } label: {
                Image(systemName: "calendar")
                    .frame(width: 44, height: 44)
                    .background(Color.white.opacity(0.1), in: Circle())
            }
            .buttonStyle(.plain)
            
            Button {
                viewModel.editGoal()
            } label: {
                Image(systemName: "pencil.and.outline")
                    .frame(width: 44, height: 44)
                    .background(Color.white.opacity(0.1), in: Circle())
            }
            .buttonStyle(.plain)
        }
        .font(.title3)
        .foregroundStyle(.white)
    }
    
    private var dateHeader: some View {
        Text(viewModel.dateText)
            .foregroundStyle(.gray)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var weekStrip: some View {
        HStack {
            ForEach(viewModel.weekDays) { day in
                dayCell(day)
            }
        }
    }
    
    private func dayCell(_ day: WeekDay) -> some View {
        VStack(spacing: 8) {
            Text(day.letter)
                .font(.caption)
                .bold()
                .foregroundStyle(.white)

            DayCircle(number: day.number, status: day.status, isToday: day.isToday)
        }
        .frame(maxWidth: .infinity)
    }
    
    private var statsRow: some View {
        HStack(spacing: 12) {
            statCard(icon: "flame.fill", color: .orange,
                     count: viewModel.learnedCount, label: "Learned")
            statCard(icon: "snowflake", color: .cyan,
                     count: viewModel.frozenCount, label: "Freezed")
        }
    }
    
    private func statCard(icon: String, color: Color, count: Int, label: String) -> some View {
        Button {
            // later: open details
        } label: {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(color)
                
                Text(count == 1 ? "1 day" : "\(count) days")
                    .font(.headline)
                
                Text(label)
                    .font(.caption)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(Color.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 28))
        }
        .buttonStyle(.plain)
    }
    
    private let controlWidth: CGFloat = 270
    
    private var logArea: some View {
        VStack(spacing: 12) {
            logButton
                .padding(.bottom, 36)
            
            freezeButton
            
            Text(viewModel.freezeText)
                .font(.caption)
                .foregroundStyle(.gray)
        }
        .padding(.bottom, 16)
    }
    
    private var logButton: some View {
        Button {
            viewModel.logAsLearned()
        } label: {
            Text(viewModel.isTodayLearned ? "Logged as Learned" : "Log as Learned")
                .font(.headline)
                .foregroundStyle(viewModel.canLog ? .white : .gray)
                .frame(width: controlWidth, height: controlWidth)
                .background(
                    viewModel.canLog ? Color.orange : Color.white.opacity(0.1),
                    in: Circle()
                )
        }
        .buttonStyle(.plain)
        .disabled(!viewModel.canLog)
    }
    
    private var freezeButton: some View {
        Button {
            viewModel.freezeToday()
        } label: {
            Text(viewModel.isTodayFrozen ? "Freezed for a day" : "Freeze for a day")
                .foregroundStyle(viewModel.canFreeze ? .white : .gray)
                .frame(width: controlWidth)
                .padding(.vertical, 12)
                .background(
                    viewModel.canFreeze ? Color.cyan : Color.white.opacity(0.1),
                    in: Capsule()
                )
        }
        .buttonStyle(.plain)
        .disabled(!viewModel.canFreeze)
    }
    
    private func resultArea(for result: GoalResult) -> some View {
        VStack(spacing: 8) {
            Image(systemName: result == .completed ? "hands.sparkles.fill" : "xmark.seal")
                .font(.system(size: 44))
                .foregroundStyle(.orange)

            Text(result == .completed ? "Will done!" : "You didn't reach your goal this time.")
                .font(.headline)

            Text(result == .completed ? "Ready for your next goal?" : "Want to set another goal?")
                .font(.subheadline)
                .foregroundStyle(.gray)

            Button {
                viewModel.editGoal()
            } label: {
                Label("Set a goal", systemImage: "pencil.and.outline")
                    .foregroundStyle(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.orange, in: Capsule())
                
            }
            .buttonStyle(.plain)
            .padding(.top, 48)
            
            
        }
        .foregroundStyle(.white)
    }
    
}



#Preview {
    NavigationStack{
        LogInDay(topic: "Swift", duration: .week)
    }
}

