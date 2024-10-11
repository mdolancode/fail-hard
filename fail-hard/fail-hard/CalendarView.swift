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
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
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
