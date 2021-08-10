    import XCTest
    @testable import day

    final class dayTests: XCTestCase {
        func testExample() {
            let day = EasternDay(year: 1, month: 2, day: 3)
            XCTAssertEqual(day.year, 1)
            XCTAssertEqual(day.month, 2)
            XCTAssertEqual(day.day, 3)
            print(TimeZone.knownTimeZoneIdentifiers)
        }
    }
