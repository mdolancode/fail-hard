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
        VStack(alignment: .leading, spacing: 8) {
            Text("Workouts on \(formattedDate(selectedDate))")
                .font(.headline)
                .padding([.top, .leading], 16)
            
            List {
                ForEach(filteredWorkouts, id: \.self) { workout in
                    NavigationLink(destination: EditWorkoutView(workout: workout)) {
                        WorkoutRow(workout: workout)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets()) // Remove default padding
                }
                .onDelete(perform: deleteWorkouts)
            }
            .listStyle(PlainListStyle()) // Keep the list simple and minimal
            .padding()
            .background(Color(.systemGray6)) // Background to give a card-like feel
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 4)
            .padding(.horizontal, 16)
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
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}

struct WorkoutRow: View {
    let workout: Workout
    
    var body: some View {
        HStack {
            Text(workout.name ?? "Unnamed Workout")
                .font(.body)
                .foregroundColor(.primary)
                .padding(.vertical, 10)
                .padding(.horizontal, 12)
            Spacer()
        }
        .background(Color.white)
        .cornerRadius(8) // Rounded for each list item
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }

}

struct WorkoutListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListView(selectedDate: Date())
    }
}
