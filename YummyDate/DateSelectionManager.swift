//
//  DateSelectionManager.swift
//  
//
//  Created by Sam Roman on 4/13/24.
//

import SwiftUI

public class DateSelectionManager: ObservableObject {
    @Published var selectedDate: Date

    init(initialDate: Date = Date()) {
        self.selectedDate = initialDate
    }

    func updateSelectedDate(to newDate: Date) {
        selectedDate = newDate
    }
}
