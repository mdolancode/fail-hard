//
//  CalendarGridView.swift
//  fail-hard
//
//  Created by Matthew Dolan on 2024-11-04.
//

import SwiftUI

struct CalendarGridView: View {
    let daysInMonth: [Date]
    @Binding var selectedDate: Date?
    let workouts: FetchedResults<Workout>
    let onSelectDate: (Date) -> Void
    
    var body: some View {
        // Days in the current month in a grid layout
        LazyVGrid(columns:Array(repeating: GridItem(), count: 7), spacing: 10) {
            ForEach(daysInMonth, id: \.self) { day in
                Text(dayString(date: day))
                    .frame(width: 40, height: 40)
                    .background(isSameDay(date1: selectedDate, date2: day) ? Color.blue : workoutForDate(day) != nil ? Color.green : Color.clear) // Green for days with a workout
                    .foregroundColor(isSameDay(date1: selectedDate, date2: day) ? .white : .black)
                    .clipShape(Circle())
                    .onTapGesture {
                        onSelectDate(day)
                    }
            }
        }
    }
    
    
    // Helper to format the date for the grid (day number)
    private func dayString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    
    
    // Helper to check if two dates are the same day
    private func isSameDay(date1: Date?, date2: Date) -> Bool {
        guard let date1 = date1 else { return false }
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    // Helper to find if there's a workout for a specific date
    private func workoutForDate(_ date: Date) -> Workout? {
        let calendar = Calendar.current
        return workouts.first(where: {
            guard let workoutDate = $0.date else { return false }
            return calendar.isDate(workoutDate, inSameDayAs: date)
        })
    }
}


