//
//  YummyDateBar.swift
//
//
//  Created by Sam Roman on 4/13/24.
//

import SwiftUI

public struct YummyDateBar: View {
    @ObservedObject var selectionManager: DateSelectionManager
    
    @Binding var selectedDate: Date
    
    var onDateTapped: () -> Void
    var onCalendarTapped: () -> Void
    
    @State var isExpanded = false
    
    var theme: YummyTheme
    
    public var body: some View {
        VStack {
            HStack {
                Button(action: {
                    withAnimation(.easeIn) {
                        self.isExpanded.toggle()
                    }
                    //This can be replaced with onCalendarTapped to open a full calendar or present more options
                }) {
                    Image(systemName: "calendar")
                        .imageScale(.medium)
                        .foregroundColor(theme.primaryColor)
                }
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.isExpanded.toggle()
                        self.selectedDate = Date()
                        selectionManager.updateSelectedDate(to: Date())
                        onDateTapped()
                    }}) {
                    if isExpanded {
                        if Calendar.current.isDateInToday(selectedDate) {
                            Text("Today, \(selectedDate.formatted(.dateTime.year().month().day()))")
                                .font(theme.primaryFont)
                                .foregroundColor(theme.primaryColor)
                        } else {
                            Text(selectedDate.formatted(.dateTime.year().month().day()))
                                .font(theme.primaryFont)
                                .foregroundColor(theme.primaryColor)
                        }
                    } else {
                        if Calendar.current.isDateInToday(selectedDate) {
                            Text("Today")
                                .font(theme.primaryFont)
                                .foregroundColor(theme.primaryColor)
                        } else {
                            Text(selectedDate.formatted(.dateTime.year().month().day()))
                                .font(theme.primaryFont)
                                .foregroundColor(theme.primaryColor)
                        }
                    }
                }
            }
            .padding([.vertical,.horizontal])
            if isExpanded {
                DateSelectorView(selectionManager: selectionManager, selectedDate: $selectedDate, theme: theme)
                    .padding(.horizontal)
            }
        }
    }
}
