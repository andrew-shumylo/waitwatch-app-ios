//
//  AddMomentView.swift
//  waitwatchapp
//
//  Created by A.Shumylo on 11.09.2024.
//

import SwiftUI

struct WaitWatchView: View {
    @StateObject private var timerViewModel = TimerViewModel()
    @Binding var isAddingMoment: Bool
    @State private var showingAddMomentModal = false
    @State private var momentName: String = ""

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack {
                HStack {
                    Text("WaitWatch")
                        .font(.system(size: 34, weight: .heavy, design: .default))
                        .foregroundColor(.white)
                        .padding(.top, 50)
                    Spacer()
                }
                .padding(.horizontal, 30)

                Spacer()

                DatePicker(
                    "",
                    selection: $timerViewModel.targetDate,
                    in: Date()...,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .datePickerStyle(WheelDatePickerStyle())
                .colorScheme(.dark)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(15)
                .shadow(radius: 5)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 30)

                Spacer()

                if timerViewModel.showCountdown {
                    VStack {
                        if !timerViewModel.yearsMonthsDays.isEmpty || !timerViewModel.hoursMinutesSeconds.contains("The moment has arrived!") {
                            Text("To your moment left:")
                                .font(.system(size: 24, weight: .heavy, design: .default))
                                .foregroundColor(.white)
                                .padding(.horizontal, 30)
                        }

                        if !timerViewModel.yearsMonthsDays.isEmpty {
                            Text(timerViewModel.yearsMonthsDays)
                                .font(.system(size: 48, weight: .thin, design: .default))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 30)
                        }

                        Text(timerViewModel.hoursMinutesSeconds)
                            .font(.system(size: 48, weight: .thin, design: .default))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                    }
                }

                Spacer()

                VStack {
                    Spacer()

                    if timerViewModel.showCountdown {
                        Button(action: {
                            showingAddMomentModal = true
                        }) {
                            Text("Add Moment +")
                                .font(.system(size: 20, weight: .medium))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .shadow(radius: 5)
                        }
                        .padding(.horizontal, 43)
                        .padding(.bottom, 10)
                        .sheet(isPresented: $showingAddMomentModal) {
                            AddMomentView(isAddingMoment: $isAddingMoment, momentName: $momentName, timerViewModel: timerViewModel)
                        }
                    }

                    Button(action: timerViewModel.startCountdown) {
                        Text("Until the Moment left...")
                            .font(.system(size: 20, weight: .medium))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal, 43)
                    .padding(.bottom, 30)
                }
            }
        }
        .onAppear(perform: timerViewModel.resetTimer)
    }
}

struct WaitWatchView_Previews: PreviewProvider {
    static var previews: some View {
        WaitWatchView(isAddingMoment: .constant(false))
    }
}
