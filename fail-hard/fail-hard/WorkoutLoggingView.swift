//
//  WorkoutLoggingView.swift
//  fail-hard
//
//  Created by Matthew Dolan on 2024-10-11.
//

import SwiftUI

struct WorkoutLoggingView: View {
    var body: some View {
        Text("hello")
    }
    
    func dayString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}

struct WorkoutLoggingView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutLoggingView()
    }
}
