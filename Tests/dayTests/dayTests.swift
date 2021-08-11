    import XCTest
    @testable import day

    final class dayTests: XCTestCase {
        func testInit() {
            let day = EasternDay(year: 1, month: 2, day: 3)
            XCTAssertEqual(day.year, 1)
            XCTAssertEqual(day.month, 2)
            XCTAssertEqual(day.day, 3)
        }
        
        func testInitToday() {
            let day = EasternDay()
            let now = Date()
            var calendar = Calendar.init(identifier: .gregorian)
            calendar.timeZone = TimeZone(identifier: "America/New_York")!
            let components = calendar.dateComponents([.year, .month, .day], from: now)

            XCTAssertEqual(day.year, components.year)
            XCTAssertEqual(day.month, components.month)
            XCTAssertEqual(day.day, components.day)
        }
        
        func testInitFromDate() {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime]
            let date = formatter.date(from: "2021-08-11T05:06:11Z")!
            
            let et = EasternDay(date: date)
            XCTAssertEqual(et.year, 2021)
            XCTAssertEqual(et.month, 8)
            XCTAssertEqual(et.day, 11)
            let ct = CentralDay(date: date)
            XCTAssertEqual(ct.year, 2021)
            XCTAssertEqual(ct.month, 8)
            XCTAssertEqual(ct.day, 11)
            let mt = MountainDay(date: date)
            XCTAssertEqual(mt.year, 2021)
            XCTAssertEqual(mt.month, 8)
            XCTAssertEqual(mt.day, 10)
            let pt = PacificDay(date: date)
            XCTAssertEqual(pt.year, 2021)
            XCTAssertEqual(pt.month, 8)
            XCTAssertEqual(pt.day, 10)
        }
        
        func testCustomStringConvertible() {
            let day = EasternDay(year: 2021, month: 8, day: 11)
            XCTAssertEqual("\(day)", "Aug 11, 2021")
        }
        
        func testEquatable() {
            let day1 = EasternDay(year: 2021, month: 8, day: 11)
            
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime]
            let date = formatter.date(from: "2021-08-11T11:06:11Z")!
            let day2 = EasternDay(date: date)
            
            let day3 = EasternDay(year: 2021, month: 8, day: 12)

            XCTAssertEqual(day1, day2)
            XCTAssertNotEqual(day1, day3)
            XCTAssert(day1 == day2)
            XCTAssert(day1 != day3)
        }

        func testComparable() {
            let day1 = EasternDay(year: 2021, month: 8, day: 11)
            let day2 = EasternDay(year: 2021, month: 8, day: 12)
            let day3 = EasternDay(year: 2021, month: 9, day: 11)
            let day4 = EasternDay(year: 2022, month: 8, day: 11)

            XCTAssertLessThan(day1, day2)
            XCTAssertLessThan(day1, day3)
            XCTAssertLessThan(day1, day4)
            XCTAssert(day1 < day2)
            XCTAssert(day1 < day3)
            XCTAssert(day1 < day4)
            XCTAssertGreaterThan(day4, day3)
            XCTAssert(day4 > day3)
            XCTAssertFalse(day3 > day4)
            XCTAssertFalse(day2 < day1)
            XCTAssertFalse(day2 > day2)
            XCTAssertFalse(day2 < day2)
            XCTAssertLessThanOrEqual(day2, day2)
            XCTAssertGreaterThanOrEqual(day2, day2)
            XCTAssert(day2 >= day2)
            XCTAssert(day2 <= day2)
        }

    }
