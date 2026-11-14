//
//  Duration.swift
//  Learning
//
//  Created by Shahad Almashjari on 12/11/2026.
//

enum Duration: String, CaseIterable, Identifiable {
    case week = "Week"
    case month = "Month"
    case year = "Year"

    var id: String { rawValue }
   
    var freezeLimit: Int {
            switch self {
            case .week:  return 2
            case .month: return 8
            case .year:  return 96
            }
        }
}
