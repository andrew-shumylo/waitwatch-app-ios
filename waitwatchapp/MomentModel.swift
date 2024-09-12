//
//  MomentModel.swift
//  waitwatchapp
//
//  Created by A.Shumylo on 11.09.2024.
//

import Foundation

struct MomentModel: Identifiable, Codable {
    var id = UUID()
    var name: String
    var targetDate: Date
    var isSelected = false
    var isPinned = false
    var moments: [MomentModel] = []
}
