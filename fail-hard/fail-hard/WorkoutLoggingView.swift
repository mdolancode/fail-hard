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
    @State private var volume: Float = 0.8 // Default volume
    @State private var audioPlayer: AVAudioPlayer?
    
    // Add presentationMode to dismiss the view
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Log Workout for \(dayString(date:selectedDate))")
                .font(.headline)
                .padding()
            
            TextField("Workout Name", text: $workoutName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Save Workout") {
                saveWorkoutAndDismiss()
            }
            .padding()
            
            Slider(value: $volume, in: 0...1) // Slider for volume adjustment
                .padding()
                .onChange(of: volume) { newValue in
                    audioPlayer?.volume = newValue
                }
        }
        
        .onAppear {
            prepareAudioPlayer()
        }
        
        .navigationTitle("Log Workout")
    }
    
    // Save workout and navigate back to the main screen
    func saveWorkoutAndDismiss() {
        guard !workoutName.trimmingCharacters(in: .whitespaces).isEmpty else {
            print("Workout name cannot be empty")
            return
        }
        
        CoreDataManager.shared.saveWorkout(name: workoutName, date: selectedDate)
        playCelebrationSound()
        print("Workout logged for \(selectedDate): \(workoutName)")
        
        // SQLite data path
//        if let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
//            print("Core Data SQLite file location: \(url)")
//        }
        
        // Dismiss the view after a slight delay ( to allow the sound to play)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
            presentationMode.wrappedValue.dismiss()
        }
        
    }
    
    // Prepare Audio Player with initial volume
    func prepareAudioPlayer() {
        guard let soundURL = Bundle.main.url(forResource: "celebration", withExtension: "wav") else {
            print("Sound file not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.volume = volume // Sets initial volume
        } catch {
            print("Error initializing audio player: \(error.localizedDescription)")
        }
    }
    
    func playCelebrationSound() {
        guard let soundURL = Bundle.main.url(forResource: "celebration", withExtension: "wav") else {
            print("Main sound file not found, playing fallback sound")
            playFallBackSound()
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
            playFallBackSound()
        }
    }
    
    func playFallBackSound() {
        // Provide a fallback sound in case the main sound fails
        guard let fallbackSoundURL = Bundle.main.url(forResource: "fallback", withExtension: "wav") else {
            print("Fallback sound file not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: fallbackSoundURL)
            audioPlayer?.play()
        } catch {
            print("Error playing fallback sound: \(error.localizedDescription)")
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
