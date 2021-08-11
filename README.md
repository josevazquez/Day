# Day

Day is a simple struct meant for dealing with entire days, rather than specific instances in time (i.e. a `Date`). A day is just a wrapper around a DateComponents instance which holds exactly a year, a month and a day (no time of day elements). Importantly, `Day` is a generic that takes a `TimeZoneProdiver` which simply vends a `TimeZone`. For convenience, a couple of typealiases have been declared to map to U.S. time zones, but any time zone can be supported by creating a provider.

### example
``` swift
let day = EasternDay(year: 2021, month: 8, day: 10)
print(day)                     // Aug 10, 2021
print(day - 15)                // Jul 26, 2021
print(Array(day..<(day + 3)))  // [Aug 10, 2021, Aug 11, 2021, Aug 12, 2021]
print((day + 500).date)        // 2022-12-23 05:00:00 +0000
```
