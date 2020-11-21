//
//  Date+Comparison.swift
//  CS_Common_Utils
//
//  Created by Christian Slanzi on 21.11.20.
//

public extension Date {
  func isSameDate(_ comparisonDate: Date) -> Bool {
    let order = Calendar.current.compare(self, to: comparisonDate, toGranularity: .day)
    return order == .orderedSame
  }

  func isBeforeDate(_ comparisonDate: Date) -> Bool {
    let order = Calendar.current.compare(self, to: comparisonDate, toGranularity: .day)
    return order == .orderedAscending
  }

  func isAfterDate(_ comparisonDate: Date) -> Bool {
    let order = Calendar.current.compare(self, to: comparisonDate, toGranularity: .day)
    return order == .orderedDescending
  }
}

public extension Date {
    static var today: Date { return Date() }
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow: Date { return Date().dayAfter }
    
    static var lastWeek: Date { return Date().lastWeek }
    static var nextWeek: Date { return Date().nextWeek }
    static var last2Week: Date { return Date().last2Week }
    static var next2Week: Date { return Date().next2Week }
    static var lastMonth: Date { return Date().lastMonth }
    static var nextMonth: Date { return Date().nextMonth }
    
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}

public extension Date {
    var lastWeek: Date {
       return Calendar.current.date(byAdding: .day, value: -7, to: self)!
    }
    var nextWeek: Date {
        return Calendar.current.date(byAdding: .day, value: 7, to: self)!
    }
    var last2Week: Date {
       return Calendar.current.date(byAdding: .day, value: -14, to: self)!
    }
    var next2Week: Date {
        return Calendar.current.date(byAdding: .day, value: 14, to: self)!
    }
    var lastMonth: Date {
       return Calendar.current.date(byAdding: .month, value: -1, to: self)!
    }
    var nextMonth: Date {
        return Calendar.current.date(byAdding: .month, value: 1, to: self)!
    }
}
