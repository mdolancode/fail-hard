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
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
