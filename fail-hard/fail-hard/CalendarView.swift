//
//  ContentView.swift
//  fail-hard
//
//  Created by Matthew Dolan on 2024-10-11.
//

// Fail Hard! How to transform your life.

import SwiftUI

struct CalendarView: View {
    // Track the current date and selected date
    @State private var currentDate = Date()
    @State private var selectedDate: Date?
    @State private var showWorkoutListModal = false
    
    // Fetch workouts from Core Data
    @FetchRequest(
        entity: Workout.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Workout.date, ascending: true)]
    ) private var workouts: FetchedResults<Workout>
    
    var body: some View {
        NavigationView {
            VStack {
                // HeaderView with navigation buttons
                HeaderView(
                    currentDate: currentDate,
                    onPreviousMonth: goToPreviousMonth,
                    onNextMonth: goToNextMonth
                )
                // Days of the week header
                HStack {
                    ForEach(["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"], id: \.self) { day in
                        Text(day)
                            .frame(maxWidth: .infinity)
                    }
                }
                
                CalendarGridView(
                    daysInMonth: daysInMonth,
                    selectedDate: $selectedDate,
                    workouts: workouts,
                    onSelectDate: { date in
                        if hasWorkouts(for: date) {
                            selectedDate = date
                            showWorkoutListModal = true
                        }
                    }
                )
                
                Spacer()
            }
            .navigationTitle("Workout Logger")
            .sheet(isPresented: $showWorkoutListModal) {
                if let selectedDate = selectedDate {
                    WorkoutListView(selectedDate: selectedDate)
                }
            }
            .padding()
        }
    }
    
    // Date-related helpers
    private var daysInMonth: [Date] {
        let calendar = Calendar.current
        guard let range = calendar.range(of: .day, in: .month, for: currentDate) else { return [] }
        return range.compactMap { day -> Date? in
            var components = calendar.dateComponents([.year, .month], from: currentDate)
            components.day = day
            return calendar.date(from: components)
        }
    }
    
    // Update currentDate to the previous month
    private func goToPreviousMonth() {
        currentDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate) ?? currentDate
    }
    private func goToNextMonth() {
        currentDate = Calendar.current.date(byAdding: .month, value: 1, to: currentDate) ?? currentDate
    }
    
    private func hasWorkouts(for date: Date) -> Bool {
        let calendar = Calendar.current
        return workouts.contains { workout in
            guard let workoutDate = workout.date else { return false }
            return calendar.isDate(workoutDate, inSameDayAs: date)
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
