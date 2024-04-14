//
//  DateSelectorView.swift
//  
//
//  Created by Sam Roman on 4/13/24.
//

import SwiftUI
import Combine

public struct DateSelectorView: View {
    @ObservedObject var selectionManager: BaseDateSelectionManager
    @Binding public var selectedDate: Date
    @State public var weekDates: [Date] = []
    @State public var centerIndex: Int = 0  // Used only for infinite scrolling

    
    public let calendar = Calendar.current
    public let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM"
        return formatter
    }()
    
    public var theme: YummyTheme
    
    public init(selectionManager: BaseDateSelectionManager, selectedDate: Binding<Date>, theme: YummyTheme) {
          self.selectionManager = selectionManager
          self._selectedDate = selectedDate
          self.theme = theme
          self.dateFormatter.dateFormat = "E, dd MMM"
      }
    
    public var body: some View {
        ScrollViewReader { proxy in
            HStack {
                Button("<") {
                    withAnimation(theme.animation) {
                        moveWeek(by: -1)
                    }
                }
                .accessibilityLabel("back week")
                .font(theme.primaryFont)
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(theme.tertiaryColor)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(weekDates.indices, id: \.self) { index in
                            DateButton(date: weekDates[index], isSelected: isDateSelected(weekDates[index]), dateFormatter: dateFormatter, theme: theme) {
                                withAnimation(theme.animation) {
                                    selectedDate = weekDates[index]
                                    selectionManager.updateSelectedDate(to: weekDates[index])
                                }
                            }
                            .id(index)
                        }
                    }
                    .padding(.horizontal)
                }
                .onAppear() {
                    setupWeekDates()
                    adjustWeekDates(for: selectedDate)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        proxy.scrollTo(3, anchor: .center)
                    }
                }
                .onChange(of: selectedDate) { newDate in
                    adjustWeekDates(for: newDate)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(theme.animation) {
                            proxy.scrollTo(3, anchor: .center)
                        }
                    }
                }

                Button(">") {
                    withAnimation(theme.animation) {
                        moveWeek(by: 1)
                    }
                }
                .accessibilityLabel("forward week")
                .font(theme.primaryFont)
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(theme.tertiaryColor)
            }
        }
    }
    
    public func setupWeekDates() {
        adjustWeekDates(for: selectedDate)
    }
    
    public func adjustWeekDates(for date: Date) {
        generateWeekDates(centeredAround: date)
    }
    
    public func generateWeekDates(centeredAround referenceDate: Date) {
        var dates = [Date]()
        for offset in -3...3 {
            if let date = calendar.date(byAdding: .day, value: offset, to: referenceDate) {
                dates.append(date)
            }
        }
        weekDates = dates
    }
    
    public func moveWeek(by offset: Int) {
        guard let shiftedWeekStart = calendar.date(byAdding: .weekOfYear, value: offset, to: weekDates.first ?? selectedDate) else { return }
        generateWeekDates(centeredAround: shiftedWeekStart)
    }

    public func isDateSelected(_ date: Date) -> Bool {
        calendar.isDate(selectedDate, inSameDayAs: date)
    }
}

public struct DateButton: View {
    let date: Date
    let isSelected: Bool
    let dateFormatter: DateFormatter
    var theme: YummyTheme
    let action: () -> Void

    public var body: some View {
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
