//
//  DateSelectionManager.swift
//  
//
//  Created by Sam Roman on 4/13/24.
//

import SwiftUI

protocol DateSelectionManaging: AnyObject {
    var selectedDate: Date { get set }
    func updateSelectedDate(to newDate: Date)
}

public class DateSelectionManager: ObservableObject, DateSelectionManaging {
    @Published var selectedDate: Date

    public init(initialDate: Date = Date()) {
        self.selectedDate = initialDate
    }

    func updateSelectedDate(to newDate: Date) {
        selectedDate = newDate
    }
}
