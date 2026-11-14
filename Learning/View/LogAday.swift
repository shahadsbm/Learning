//
//  LogAday.swift
//  Learning
//
//  Created by Shahad Almashjari on 14/11/2026.
//

import SwiftUI

struct LogInDay : View {
    
    
    @State private var viewModel: StartLG

    init(topic: String, duration: Duration) {
        _viewModel = State(initialValue: StartLG(topic: topic, duration: duration))
    }
       var body: some View {
           VStack {
               topBar
               dateHeader
               weekStrip
               statsRow

               Spacer()

               logArea
                   .navigationBarBackButtonHidden(true)
                   .toolbar(.hidden, for: .navigationBar)
           }
           .padding(.horizontal, 16)
       }

       // MARK: - Sections (placeholders for now)

    private var topBar: some View {
        HStack(spacing: 12) {
            Text("Activity")
                .font(.largeTitle)
                .bold()

            Spacer()

            Button {
                // later: open the calendar
            } label: {
                Image(systemName: "calendar")
                    .frame(width: 44, height: 44)
                    .background(Color.white.opacity(0.1), in: Circle())
            }
            .buttonStyle(.plain)

            Button {
                // later: edit the goal
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

            Text("\(day.number)")
                .font(.title3)
                .fontWeight(day.isToday ? .bold : .regular)
                .frame(width: 44, height: 44)
                .foregroundStyle(numberColor(for: day))
                .background(circleColor(for: day), in: Circle())
        }
        .frame(maxWidth: .infinity)
    }

    private func numberColor(for day: WeekDay) -> Color {
        switch day.status {
        case .learned: return .orange
        case .frozen:  return .cyan
        case nil:      return .white
        }
    }

    private func circleColor(for day: WeekDay) -> Color {
        switch day.status {
        case .learned: return .orange.opacity(0.2)
        case .frozen:  return .cyan.opacity(0.2)
        case nil:      return day.isToday ? .orange : .clear
        }
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
                .foregroundStyle(viewModel.isTodayLogged ? .gray : .white)
                .frame(width: controlWidth, height: controlWidth)
                .background(
                    viewModel.isTodayLogged ? Color.white.opacity(0.1) : Color.orange,
                    in: Circle()
                )
        }
        .buttonStyle(.plain)
        .disabled(viewModel.isTodayLogged)
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
    
   }



#Preview {
    LogInDay(topic: "Swift", duration: .week)
}

