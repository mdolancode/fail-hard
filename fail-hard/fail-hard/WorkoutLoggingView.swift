//
//  WorkoutLoggingView.swift
//  fail-hard
//
//  Created by Matthew Dolan on 2024-10-11.
//

import SwiftUI

struct WorkoutLoggingView: View {
    let selectedDate: Date
    @State private var workoutName: String = ""
    
    var body: some View {
        VStack {
            Text("Log Workout for \(dayString(date:selectedDate))")
                .font(.headline)
                .padding()
            
            TextField("Workout Name", text: $workoutName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Save Workout") {
                CoreDataManager.shared.saveWorkout(name: workoutName, date: selectedDate)
                //Add logic to play sound here later!
                print("Workout logged for \(selectedDate): \(workoutName)")
            }
            .padding()
        }
        .navigationTitle("Log Workout")
    }
    
    func dayString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}

struct WorkoutLoggingView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutLoggingView(selectedDate: Date())
    }
}
