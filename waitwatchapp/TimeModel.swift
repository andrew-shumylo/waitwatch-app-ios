//
//  TimeModel.swift
//  waitwatchapp
//
//  Created by A.Shumylo on 11.09.2024.
//

import Foundation

struct TimeModel {
    var years: Int
    var months: Int
    var days: Int
    var hours: Int
    var minutes: Int
    var seconds: Int

    init(timeInterval: TimeInterval) {
        var interval = Int(timeInterval)

        // Calculate each component from the time interval
        self.years = interval / 31536000
        interval %= 31536000
        
        let totalDays = interval / 86400
        interval %= 86400
        
        // Approximate months and calculate remaining days
        self.months = totalDays / 30
        self.days = totalDays % 30
        
        if self.months >= 12 {
            self.days += (self.months / 12) * 30
            self.months %= 12        }

        self.hours = interval / 3600
        interval %= 3600
        self.minutes = interval / 60
        self.seconds = interval % 60
    }

    func formattedDateComponents() -> String {
        var components = [String]()
        if years > 0 {
            components.append(String(format: "%02dy", years))
        }
        if months > 0 || (!components.isEmpty && days > 0) {
            components.append(String(format: "%02dm", months))
        }
        if days > 0 {
            components.append(String(format: "%02dd", days))
        }
        return components.joined(separator: " ")
    }

    func formattedTimeComponents() -> String {
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
