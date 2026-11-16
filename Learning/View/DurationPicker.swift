//
//  DurationPicker.swift
//  Learning
//
//  Created by Shahad Almashjari on 16/11/2026.
//

import SwiftUI

struct DurationPicker: View {
    @Binding var selection: Duration

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("I want to learn it in a")

            HStack(spacing: 12) {
                ForEach(Duration.allCases, id: \.self) { item in
                    Button(item.rawValue) {
                        selection = item
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .foregroundStyle(selection == item ? .white : .gray)
                    .background(
                        selection == item ? Color.orange : Color.white.opacity(0.1),
                        in: Capsule()
                    )
                }
            }
        }
    }
}
