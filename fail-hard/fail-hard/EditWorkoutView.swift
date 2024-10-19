//
//  EditWorkoutView.swift
//  fail-hard
//
//  Created by Matthew Dolan on 2024-10-14.
//

import SwiftUI
import CoreData

struct EditWorkoutView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var workout: Workout // Use ObservedObject to observe changes in the workout
    @State private var isinputValid: Bool = true // Track input validity
    
    var body: some View {
        Form {
            TextField("Workout Name", text: Binding(
                get: { workout.name ?? "" }, // Use an empty string if the name is nil
                set: { newValue in
                    workout.name = newValue.isEmpty ? nil : newValue
                    isinputValid = !newValue.trimmingCharacters(in: .whitespaces).isEmpty // Validate input
                    
                } // Set to nil if the user clears the text
                ))
            // Add more fields as necessary, e.g., duration, type of workout
            
            if !isinputValid {
                Text("workout name cannot be empty.")
                    .foregroundColor(.red)
            }
            
            
            Button("Save") {
                // Save the edited workout details to Core Data
                if isinputValid {
                    saveWorkout()
                    dismiss()
                }
            }
            .disabled(!isinputValid)
        }
        .navigationTitle("Edit Workout")
    }
    
    private func saveWorkout() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        do {
            try context.save()
        } catch {
            print("Error saving edited workout: \(error.localizedDescription)")
        }
    }
}

extension Workout {
    static func example() -> Workout {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let workout = Workout(context: context)
        workout.name = "Example Workout"
        // Set other properties as needed
        return workout
    }
}

struct EditWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample workout instance for preview
        let workout = Workout.example()
        
        // Wrap the workout in a Binding
        EditWorkoutView(workout: workout)
    }
}
