//
//  DateSelectionManagerTests.swift
//  YummyDateTests
//
//  Created by Sam Roman on 4/14/24.
//

import XCTest

@testable import YummyDate

class DateSelectionManagerTests: XCTestCase {

    func testDateUpdate() {
        let manager = DateSelectionManager()
        let initialDate = manager.selectedDate
        let newDate = Date(timeIntervalSince1970: 1622505600) // specific date
        
        manager.updateSelectedDate(to: newDate)
        
        XCTAssertNotEqual(manager.selectedDate, initialDate, "Selected date should be updated.")
        XCTAssertEqual(manager.selectedDate, newDate, "Selected date did not update correctly.")
    }
}
