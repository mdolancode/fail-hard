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
    @Binding var workout: Workout // Your Core Data workout entity
    
    var body: some View {
        Form {
            TextField("Workout Name", text: Binding(
                get: { workout.name ?? "" }, // Use an empty string if the name is nil
                set: { workout.name = $0.isEmpty ? nil : $0 } // Set to nil if the user clears the text
                ))
            // Add more fields as necessary, e.g., duration, type of workout
            
            
            Button("Save") {
                // Save the edited workout details to Core Data
                saveWorkout()
                dismiss()
            }
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
        EditWorkoutView(workout: Binding<Workout>(
        get: { workout },
        set: { _ in }
        ))
    }
}
