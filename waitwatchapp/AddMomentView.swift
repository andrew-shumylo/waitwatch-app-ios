//
//  AddMomentView.swift
//  waitwatchapp
//
//  Created by A.Shumylo on 12.09.2024.
//

import SwiftUI

struct AddMomentView: View {
    @Binding var isAddingMoment: Bool
    @Binding var momentName: String
    @ObservedObject var timerViewModel: TimerViewModel

    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                TextField("Moment Name", text: $momentName)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding()

                Spacer()
                
                Button(action: addMoment) {
                    Text("Save Moment")
                        .font(.system(size: 20, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isValidMomentName() ? Color.orange : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
                .disabled(!isValidMomentName())

                Spacer()
            }
            .navigationTitle("Add Moment")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
            .preferredColorScheme(.dark)
        }
    }

    private func isValidMomentName() -> Bool {
        return momentName.count >= 1 && momentName.count <= 32
    }

    private func addMoment() {
        if isValidMomentName() {
            timerViewModel.addMoment(name: momentName)
            presentationMode.wrappedValue.dismiss()
            isAddingMoment = false // Navigate back to Moments list
        }
    }
}

struct AddMomentView_Previews: PreviewProvider {
    static var previews: some View {
        AddMomentView(isAddingMoment: .constant(true), momentName: .constant(""), timerViewModel: TimerViewModel())
    }
}
