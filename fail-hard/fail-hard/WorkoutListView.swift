//
//  WorkoutListView.swift
//  fail-hard
//
//  Created by Matthew Dolan on 2024-10-16.
//

import SwiftUI
import CoreData

struct WorkoutListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Workout.entity(),
        sortDescriptors:[NSSortDescriptor(keyPath: \Workout.date, ascending: true)],
        animation: .default)
    private var workouts: FetchedResults<Workout>
    
    let selectedDate: Date // Passed from CalendarView
    
    var body: some View {
            List {
                ForEach(filteredWorkouts, id: \.self) { workout in
                    NavigationLink(destination: EditWorkoutView(workout: workout)) {
                        Text(workout.name ?? "Unnamed Workout")
                    }
                }
                .onDelete(perform: deleteWorkouts)
            }
    }
    
    private var filteredWorkouts: [Workout] {
        let calendar = Calendar.current
        return workouts.filter { workout in
            guard let workoutDate = workout.date else { return false }
            return calendar.isDate(workoutDate, inSameDayAs: selectedDate)
            
        }
    }
 
    private func deleteWorkouts(offsets: IndexSet) {
        withAnimation {
            offsets.map {workouts[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                // Handle the error appropriately
                print("Failed to delete workout: \(error.localizedDescription)")
            }
        }
        
    }
}

struct WorkoutListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListView(selectedDate: Date())
    }
}
