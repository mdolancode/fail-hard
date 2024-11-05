//
//  HeaderView.swift
//  fail-hard
//
//  Created by Matthew Dolan on 2024-11-04.
//

import SwiftUI

struct HeaderView: View {
    let currentDate: Date
    let onPreviousMonth: () -> Void
    let onNextMonth: () -> Void
    
    var body: some View {
        HStack{
            Button(action: onPreviousMonth) {
                Image(systemName: "chevron.left")
                    .padding()
            }
            
            VStack {
                Text(monthAndYearString(date: currentDate))
                    .font(.title2)
            }
            Button(action: onNextMonth) {
                Image(systemName: "chevron.right")
                    .padding()
            }
        }
    }
}
    
    // Helper to format the month and year
    private func monthAndYearString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }

//struct HeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        HeaderView(currentDate: , onPreviousMonth: , onNextMonth: <#() -> Void#>)
//    }
//}
