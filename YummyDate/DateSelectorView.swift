//
//  DateSelectorView.swift
//  
//
//  Created by Sam Roman on 4/13/24.
//

import SwiftUI

public struct DateSelectorView: View {
    @ObservedObject var selectionManager: DateSelectionManager
    @Binding var selectedDate: Date
    @State private var weekDates: [Date] = []
    
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM"
        return formatter
    }()
    
    var theme: YummyTheme
    
    public var body: some View {
        HStack {
            Button("<") {
                withAnimation(.easeInOut(duration: 0.2)) {
                    moveWeek(by: -1)
                }
            }
            .font(theme.primaryFont)
            .buttonStyle(PlainButtonStyle())
            .foregroundColor(theme.tertiaryColor)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(weekDates, id: \.self) { date in
                        DateButton(date: date, isSelected: isDateSelected(date), dateFormatter: dateFormatter, theme: theme) {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                selectedDate = date
                                selectionManager.updateSelectedDate(to: date)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .onAppear(perform: setupWeekDates)

            Button(">") {
                withAnimation(.easeInOut(duration: 0.2)) {
                    moveWeek(by: 1)
                }
            }
            .font(theme.primaryFont)
            .buttonStyle(PlainButtonStyle())
            .foregroundColor(theme.tertiaryColor)
        }
        .onChange(of: selectedDate) { newDate in
            adjustWeekDates(for: newDate)
        }
    }
    
    private func setupWeekDates() {
        adjustWeekDates(for: selectedDate)
    }
    
    private func adjustWeekDates(for date: Date) {
        if !weekDates.contains(where: { calendar.isDate($0, inSameDayAs: date) }) {
            generateWeekDates(startingFrom: date)
        }
    }
    
    private func generateWeekDates(startingFrom referenceDate: Date) {
        guard let weekStart = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: referenceDate)) else { return }
        weekDates = (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: weekStart) }
    }
    
    private func moveWeek(by offset: Int) {
        guard let shiftedWeekStart = calendar.date(byAdding: .weekOfYear, value: offset, to: weekDates.first ?? selectedDate) else { return }
        generateWeekDates(startingFrom: shiftedWeekStart)
    }

    private func isDateSelected(_ date: Date) -> Bool {
        calendar.isDate(selectedDate, inSameDayAs: date)
    }
}

struct DateButton: View {
    let date: Date
    let isSelected: Bool
    let dateFormatter: DateFormatter
    var theme: YummyTheme
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(dateFormatter.string(from: date))
                .font(theme.secondaryFont)
                .foregroundColor(isSelected ? theme.primaryTextColor : theme.tertiaryColor)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(isSelected ? theme.primaryColor : Color.clear)
                .cornerRadius(20)
        }
    }
}
