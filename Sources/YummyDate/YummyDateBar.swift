//
//  YummyDateBar.swift
//
//
//  Created by Sam Roman on 4/13/24.
//

import SwiftUI

public struct YummyDateBar: View {
    @ObservedObject var selectionManager: BaseDateSelectionManager
    
    @Binding var selectedDate: Date
    
    var onDateTapped: () -> Void
    var onCalendarTapped: () -> Void
    
    @State var isExpanded = false
    
    var theme: YummyTheme
    
    public init(selectionManager: BaseDateSelectionManager, selectedDate: Binding<Date>, onDateTapped: @escaping () -> Void, onCalendarTapped: @escaping () -> Void, theme: YummyTheme) {
         self.selectionManager = selectionManager
         self._selectedDate = selectedDate
         self.onDateTapped = onDateTapped
         self.onCalendarTapped = onCalendarTapped
         self.theme = theme
     }
     
    public var body: some View {
        VStack {
            HStack {
                Button(action: {
                    withAnimation(theme.animation) {
                        self.isExpanded.toggle()
                    }
                    //This can be replaced with onCalendarTapped to open a full calendar or present more options
                }) {
                    Image(systemName: "calendar")
                        .imageScale(.medium)
                        .foregroundColor(theme.primaryColor)
                }
                if theme.barAlignment == .center || theme.barAlignment == .leading {
                    Spacer()
                }
                Button(action: {
                    withAnimation(theme.animation) {
                        if theme.resetOnTap {
                            self.selectedDate = Date()
                            selectionManager.updateSelectedDate(to: self.selectedDate)
                        }
                        self.isExpanded.toggle()
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
                if theme.barAlignment == .trailing || theme.barAlignment == .center {
                    Spacer()
                }
            }
            .padding()
            if isExpanded {
                DateSelectorView(selectionManager: selectionManager, selectedDate: $selectedDate, theme: theme)
                    .padding(.horizontal)
            }
        }
    }
}
