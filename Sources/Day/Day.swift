//
//  Day.swift
//  PhoneBooth
//
//  Created by Jose Vazquez on 8/10/21.
//  Copyright © 2021 Jose Vazquez. All rights reserved.
//

import Foundation

/// The typeliases provided are a convenience instead of dealing
/// with the generics directly
public typealias EasternDay  = Day<EasternTimeZone>
public typealias CentralDay  = Day<CentralTimeZone>
public typealias MountainDay = Day<MountainTimeZone>
public typealias PacificDay  = Day<PacificTimeZone>
public typealias GMTDay      = Day<GMTTimeZone>


public struct Day<TZ: TimeZoneProvider>: CustomStringConvertible, Equatable, Comparable, Strideable {
    private let components: DateComponents
    
    
    // MARK: - Initializers
    public init(year: Int, month: Int, day: Int) {
        let calendar = Calendar.init(identifier: .gregorian)
        self.components = DateComponents(calendar: calendar, timeZone: TZ.timeZone, year: year, month: month, day: day)
    }

    /// Creates a Day instance based on the current time.
    public init() {
        self.init(date: Date())
    }
    
    /// Creates a Day intance based on a given `Date`
    public init(date: Date) {
        let components = Self.calendar.dateComponents([.year, .month, .day], from: date)
        self.init(year: components.year!, month: components.month!, day: components.day!)
    }
    
    
    // MARK: - Accessors
    public var year: Int { components.year! }
    public var month: Int { components.month! }
    public var day: Int { components.day! }
    public var date: Date { components.date! }
    
    
    // MARK: - FirstOf
    public func firstOfWeek(_ calendar: Calendar = Calendar(identifier: .gregorian)) -> Day<TZ> {
        var tzCalendar = calendar
        tzCalendar.timeZone = TZ.timeZone
        let weekdayOrdinal = tzCalendar.dateComponents([.weekday], from: date)
        var offset = weekdayOrdinal.weekday! - tzCalendar.firstWeekday
        if offset < 0 { offset += 7 }
        return self - offset
    }
    
    public func firstOfMonth() -> Day<TZ> {
        return Day<TZ>(year: year, month: month, day: 1)
    }

    public func firstOfQuarter() -> Day<TZ> {
        let monthInQuarter = (month - 1) % 3
        return Day<TZ>(year: year, month: month - monthInQuarter, day: 1)
    }

    public func firstOfYear() -> Day<TZ> {
        return Day<TZ>(year: year, month: 1, day: 1)
    }

    
    // MARK: - Calendar
    private static var calendar: Calendar {
        var calendar = Calendar.init(identifier: .gregorian)
        calendar.timeZone = TZ.timeZone
        return calendar
    }
        
    
    // MARK: - CustomStringConvertible
    private static var formatter: DateFormatter {
        let f = DateFormatter()
        f.dateStyle = DateFormatter.Style.medium
        f.timeZone = TZ.timeZone
        return f
    }
    
    public static var dateFormatterDayStamp: DateFormatter { // "2020-04-16"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TZ.timeZone
        return formatter
    }
    
    public var description: String {
        Self.formatter.string(from: date)
    }

    public func string(formatter: DateFormatter = dateFormatterDayStamp) -> String {
        let tzFormatter = formatter
        tzFormatter.timeZone = TZ.timeZone
        return tzFormatter.string(from: date)
    }
    
    // MARK: - Comparable
    public static func < (lhs: Day<TZ>, rhs: Day<TZ>) -> Bool {
        lhs.date < rhs.date
    }

    
    // MARK: - Strideable
    public func advanced(by n: Int) -> Day {
        Day(year: year, month: month, day: day + n)
    }

    public func distance(to other: Day) -> Int {
        Self.calendar.dateComponents([.day], from: date, to: other.date).day!
    }
}


// MARK: - Operators
public func + <TZ: TimeZoneProvider>(lhs: Day<TZ>, rhs: Int) -> Day<TZ> {
    return lhs.advanced(by: rhs)
}

public func - <TZ: TimeZoneProvider>(lhs: Day<TZ>, rhs: Int) -> Day<TZ> {
    return lhs.advanced(by: -rhs)
}

public func - <TZ: TimeZoneProvider>(lhs: Day<TZ>, rhs: Day<TZ>) -> Int {
    return rhs.distance(to: lhs)
}


// MARK: - TimeZoneProvider
public protocol TimeZoneProvider {
    static var timeZone: TimeZone { get }
}

public struct EasternTimeZone:  TimeZoneProvider { public static var timeZone: TimeZone { TimeZone(identifier: "America/New_York")! }}
public struct CentralTimeZone:  TimeZoneProvider { public static var timeZone: TimeZone { TimeZone(identifier: "America/Chicago")! }}
public struct MountainTimeZone: TimeZoneProvider { public static var timeZone: TimeZone { TimeZone(identifier: "America/Phoenix")! }}
public struct PacificTimeZone:  TimeZoneProvider { public static var timeZone: TimeZone { TimeZone(identifier: "America/Los_Angeles")! }}
public struct GMTTimeZone:      TimeZoneProvider { public static var timeZone: TimeZone { TimeZone(identifier: "GMT")! }}
