//
//  WorkoutLoggingView.swift
//  fail-hard
//
//  Created by Matthew Dolan on 2024-10-11.
//

import SwiftUI
import AVFoundation

struct WorkoutLoggingView: View {
    let selectedDate: Date
    @State private var workoutName: String = ""
    @State private var audioPlayer: AVAudioPlayer?
    
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
                playWoooSound()
                print("Workout logged for \(selectedDate): \(workoutName)")
                
                if let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
                    print("Core Data SQLite file location: \(url)")
                }
            }
            .padding()
        }
        .navigationTitle("Log Workout")
    }
    
    func playWoooSound() {
        guard let soundURL = Bundle.main.url(forResource: "wooo", withExtension: "wav") else {
            print("Sound file not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
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
