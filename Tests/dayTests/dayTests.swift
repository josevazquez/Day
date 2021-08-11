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
    }
