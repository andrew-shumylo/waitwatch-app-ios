//
//  AddMomentView.swift
//  waitwatchapp
//
//  Created by A.Shumylo on 11.09.2024.
//

import Foundation
import SwiftUI
import Combine

class TimerViewModel: ObservableObject {
    @Published var targetDate = Date()
    @Published var selectedDate = Date()
    @Published var yearsMonthsDays = ""
    @Published var hoursMinutesSeconds = ""
    @Published var showCountdown = false
    @Published var moments: [MomentModel] = []

    private var timer: Timer?
    private let momentsKey = "savedMoments"

    init() {
        loadMoments()
    }

    func startCountdown() {
        resetTimer()
        selectedDate = targetDate
        showCountdown = true // Show the countdown only after the button is tapped
        updateTimeRemaining()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.updateTimeRemaining()
        }
    }

    func updateTimeRemaining() {
        let now = Date()
        let timeInterval = selectedDate.timeIntervalSince(now)

        if timeInterval <= 0 {
            yearsMonthsDays = ""
            hoursMinutesSeconds = "The moment has arrived!"
            timer?.invalidate()
        } else {
            let timeModel = TimeModel(timeInterval: timeInterval)
            yearsMonthsDays = timeModel.formattedDateComponents()
            hoursMinutesSeconds = timeModel.formattedTimeComponents()
        }
    }

    func resetTimer() {
        timer?.invalidate()
        timer = nil
        yearsMonthsDays = ""
        hoursMinutesSeconds = ""
        showCountdown = false
    }

    func addMoment(name: String) {
        let newMoment = MomentModel(name: name, targetDate: selectedDate)
        moments.append(newMoment)
        saveMoments()
        resetTimer()
        showCountdown = false
    }

    func saveMoments() {
        if let encodedData = try? JSONEncoder().encode(moments) {
            UserDefaults.standard.set(encodedData, forKey: momentsKey)
        }
    }

    func loadMoments() {
        if let savedData = UserDefaults.standard.data(forKey: momentsKey),
           let decodedMoments = try? JSONDecoder().decode([MomentModel].self, from: savedData) {
            moments = decodedMoments
        }
    }

    func deleteMoment(at offsets: IndexSet) {
        moments.remove(atOffsets: offsets)
        saveMoments()
    }

    func pinMoment(_ moment: MomentModel) {
        // Implementation for pinning a moment
    }

    func editMoment(_ moment: MomentModel) {
        // Implementation for editing a moment
    }
}
