//
//  ActivitiesV.swift
//  Learning
//
//  Created by Shahad Almashjari on 16/11/2026.
//

import SwiftUI

struct ActivitiesView: View {
    @State private var viewModel: Activities
    @Environment(\.dismiss) private var dismiss

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)

    init(entries: [DayEntry], today: Date) {
        _viewModel = State(initialValue: Activities(entries: entries, today: today))
    }

    var body: some View {
        let months = viewModel.months

        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                ForEach(months) { month in
                    monthSection(month)

                    if month.id != months.last?.id {
                        Divider()
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .defaultScrollAnchor(.bottom)
        .safeAreaInset(edge: .top) { topBar }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }

    // MARK: - Sections

    private var topBar: some View {
        ZStack {
            Text("Activities")
                .font(.headline)

            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .frame(width: 44, height: 44)
                        .background(Color.white.opacity(0.1), in: Circle())
                }
                .buttonStyle(.plain)

                Spacer()
            }
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 16)
    }

    private func monthSection(_ month: CalendarMonth) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(month.title)
                .font(.headline)

            HStack(spacing: 0) {
                ForEach(viewModel.weekdayHeaders, id: \.self) { header in
                    Text(header)
                        .font(.caption)
                        .bold()
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity)
                }
            }

            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(0..<month.leadingBlanks, id: \.self) { _ in
                    Color.clear.frame(height: 38)
                }

                ForEach(month.days) { day in
                    DayCircle(number: day.number, status: day.status,
                              isToday: day.isToday, size: 38)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ActivitiesView(entries: [], today: Date())
    }
}
