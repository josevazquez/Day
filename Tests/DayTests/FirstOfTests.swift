//
//  FirstOfTests.swift
//  
//
//  Created by Jose Vazquez on 8/8/23.
//

import XCTest
@testable import Day

final class FirstOfTests: XCTestCase {

    func testFirstOfWeek() throws {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2 // start week on a monday

        var day = PacificDay(year: 2023, month: 8, day: 8)
        var first = day.firstOfWeek(calendar)
        XCTAssertEqual(first.string(), "2023-08-07")

        // using default calendar
        first = day.firstOfWeek()
        XCTAssertEqual(first.string(), "2023-08-06")

        day = PacificDay(year: 2023, month: 8, day: 6)
        first = day.firstOfWeek(calendar)
        XCTAssertEqual(first.string(), "2023-07-31")
        
        day = PacificDay(year: 2023, month: 8, day: 13)
        first = day.firstOfWeek(calendar)
        XCTAssertEqual(first.string(), "2023-08-07")
    }

    func testFirstOfMonth() throws {
        let day = PacificDay(year: 2023, month: 8, day: 8)
        let first = day.firstOfMonth()
        XCTAssertEqual(first.string(), "2023-08-01")
    }

    func testFirstOfQuarter() throws {
        var day = PacificDay(year: 2023, month: 8, day: 8)
        var first = day.firstOfQuarter()
        XCTAssertEqual(first.string(), "2023-07-01")

        day = PacificDay(year: 2016, month: 2, day: 28)
        first = day.firstOfQuarter()
        XCTAssertEqual(first.string(), "2016-01-01")

    }

    func testFirstOfYear() throws {
        let day = CentralDay(year: 2023, month: 8, day: 8)
        let first = day.firstOfYear()
        XCTAssertEqual(first.string(), "2023-01-01")
    }
    
}
