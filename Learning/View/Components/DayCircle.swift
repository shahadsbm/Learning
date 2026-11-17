//
//  DayCircle.swift
//  Learning
//
//  Created by Shahad Almashjari on 16/11/2026.
//

import SwiftUI

struct DayCircle: View {
    let number: Int
    let status: DayStatus?
    let isToday: Bool
    var size: CGFloat = 44

    var body: some View {
        Text("\(number)")
            .font(.title3)
            .fontWeight(isToday ? .bold : .regular)
            .frame(width: size, height: size)
            .foregroundStyle(numberColor)
            .background(circleColor, in: Circle())
    }

    private var numberColor: Color {
        switch status {
        case .learned: return .orange
        case .frozen:  return .cyan
        case nil:      return .white
        }
    }

    private var circleColor: Color {
        switch status {
        case .learned: return .orange.opacity(0.2)
        case .frozen:  return .cyan.opacity(0.2)
        case nil:      return isToday ? .orange : .clear
        }
    }
}
