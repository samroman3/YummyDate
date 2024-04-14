//
//  DateSelectionManager.swift
//  
//
//  Created by Sam Roman on 4/13/24.
//

import SwiftUI
import Combine

public protocol DateSelectionManaging: ObservableObject {
    var selectedDate: Date { get set }
    func updateSelectedDate(to newDate: Date)
}

public class BaseDateSelectionManager: DateSelectionManaging {
    @Published public var selectedDate: Date = Date()
    
    public func updateSelectedDate(to newDate: Date) {
        selectedDate = newDate
    }
}

public class CustomDateSelectionManager: BaseDateSelectionManager {

}

