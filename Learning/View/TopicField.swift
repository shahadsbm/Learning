//
//  TopicField.swift
//  Learning
//
//  Created by Shahad Almashjari on 16/11/2026.
//

import SwiftUI

struct TopicField: View {
    @Binding var topic: String
    var errorMessage: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("I want to learn")

            TextField("Enter a goal", text: $topic)

            Divider()

            if let errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundStyle(.red)
            }
        }
    }
}
