//
//  ContentView.swift
//  fail-hard
//
//  Created by Matthew Dolan on 2024-10-11.
//

import SwiftUI

struct CalendarView: View {
    // Track the current date and selected date
    @State private var currentDate = Date()
    @State private var selectedDate: Date?
    
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

    var body: some View {
        VStack {
            Text("Fail Hard!")
                .font(.largeTitle)
                .padding()
            
            // Month and year display
            Text(monthAndYearString(date: currentDate))
                .font(.title2)
                .padding()
            
            // Days of the week header
            HStack {
                ForEach(["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"], id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                }
            }
            
            // Have a sound play and celebrate after every workout is complete
            
            // Days in the current month in a grid layout
            LazyVGrid(columns:Array(repeating: GridItem(), count: 7), spacing: 10) {
                ForEach(daysInMonth, id: \.self) { day in
                    NavigationLink(destination: WorkoutLoggingView(selectedDate: day)) {
                        Text(dayString(date: day))
                            .frame(width: 40, height: 40)
                            .backgroundStyle(isSameDay(date1: selectedDate, date2: day) ? Color.blue : Color.clear)
                            .foregroundColor(isSameDay(date1: selectedDate, date2: day) ? .white : .black)
                            .clipShape(Circle())
                    }
                }
            }
            Spacer()
        }
        .padding()
    }
    
    // Helper to format the date for the grid (day number)
    private func dayString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    
    // Helper to format the month and year
    private func monthAndYearString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
    
    // Helper to check if two dates are the same day
    private func isSameDay(date1: Date?, date2: Date) -> Bool {
        guard let date1 = date1 else { return false }
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
