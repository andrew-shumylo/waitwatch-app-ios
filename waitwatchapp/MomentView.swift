//
//  MomentModel.swift
//  waitwatchapp
//
//  Created by A.Shumylo on 12.09.2024.
//

import SwiftUI

struct MomentView: View {
  @StateObject private var timerViewModel = TimerViewModel()
  @State private var showWaitWatchView = false
  @State private var isAddingMoment = false

  var body: some View {
    NavigationView {
      VStack {
        List(timerViewModel.moments) { moment in
          VStack(alignment: .leading) {
              HStack {
                  Text(moment.name)
                      .font(.headline)
                  
                  // Display a pin icon if the moment is pinned
                  if moment.isPinned {
                      Image(systemName: "pin.fill")
                          .foregroundColor(.blue)
                  }
              }

            // Placeholder for countdown logic
            Text("Countdown goes here...") // Implement Countdown logic
              .font(.subheadline)
              .foregroundColor(.gray)
          }
          .swipeActions(edge: .trailing){
            // Delete Logic
            Button(action: {
              if let index = timerViewModel.moments.firstIndex(where: { $0.id == moment.id }) {
                timerViewModel.deleteMoment(at: IndexSet(integer: index))
              }
            }) {
              Image(systemName: "trash.fill")
                .tint(.red)
            }

            Button(action: {
                        timerViewModel.pinMoment(moment)
            }) {
                Image(systemName: moment.isPinned ? "pin.slash.fill" : "pin.fill")
                    .tint(.blue)
            }
          }
        }

        Spacer()

        Button(action: {
          showWaitWatchView = true
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
        .padding(.horizontal, 30)
        .padding(.bottom, 30)
      }
      .navigationTitle("Moments")
    }
    .fullScreenCover(isPresented: $showWaitWatchView) {
      WaitWatchView(isAddingMoment: $isAddingMoment)
    }
    .preferredColorScheme(.dark)
  }
}
