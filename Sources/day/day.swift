//
//  Day.swift
//  PhoneBooth
//
//  Created by Jose Vazquez on 8/10/21.
//  Copyright © 2021 Jose Vazquez. All rights reserved.
//

import Foundation
//public struct Day<TZ: TimeZoneProvider>: CustomStringConvertible, Equatable, Comparable, ForwardIndexType, RandomAccessIndexType
public struct Day<TZ: TimeZoneProvider> {
    let components: DateComponents
    
    init(year: Int, month: Int, day: Int) {
        let calendar = Calendar.init(identifier: .gregorian)
        self.components = DateComponents(calendar: calendar, timeZone: TZ.timeZone, year: year, month: month, day: day)
    }
    
    static func today() -> Day {
        var calendar = Calendar.init(identifier: .gregorian)
        calendar.timeZone = TZ.timeZone
        let now = Date()
        let components = calendar.dateComponents([.year, .month, .day], from: now)
        return Day(year: components.year!, month: components.month!, day: components.day!)
    }
    
    var year: Int { components.year! }
    var month: Int { components.month! }
    var day: Int { components.day! }
}

public protocol TimeZoneProvider {
    static var timeZone: TimeZone { get }
}

public typealias EasternDay  = Day<EasternTimeZone>
public typealias CentralDay  = Day<CentralTimeZone>
public typealias MountainDay = Day<MountainTimeZone>
public typealias PacificDay  = Day<PacificTimeZone>

public struct EasternTimeZone:  TimeZoneProvider { public static var timeZone: TimeZone { TimeZone(identifier: "America/New_York")! }}
public struct CentralTimeZone:  TimeZoneProvider { public static var timeZone: TimeZone { TimeZone(identifier: "America/Chicago")! }}
public struct MountainTimeZone: TimeZoneProvider { public static var timeZone: TimeZone { TimeZone(identifier: "America/Phoenix")! }}
public struct PacificTimeZone:  TimeZoneProvider { public static var timeZone: TimeZone { TimeZone(identifier: "America/Los_Angeles")! }}
