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
                List {
                    ForEach(timerViewModel.moments) { moment in
                        VStack(alignment: .leading) {
                            Text(moment.name)
                                .font(.headline)
                            Text("Countdown goes here...") // Implement Countdown logic
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .onDelete(perform: timerViewModel.deleteMoment)
                    .swipeActions(edge: .trailing) {
                        Button(action: {
                            // Delete Logic
                        }){
                            Image(systemName: "trash.fill")
                                .foregroundColor(.orange)
                                .tint(.red)
                        }
                               
                        Button(action: {
                            // Pin Logic
                        }){
                            Image(systemName: "pin.fill")
                                .foregroundColor(.blue)
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
                        .background(Color.orange)
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

struct MomentView_Previews: PreviewProvider {
    static var previews: some View {
        MomentView()
    }
}
