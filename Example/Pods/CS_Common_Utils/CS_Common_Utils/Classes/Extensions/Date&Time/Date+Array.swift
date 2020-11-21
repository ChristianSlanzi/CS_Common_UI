//
//  Date+Array.swift
//  CS_Common_Utils
//
//  Created by Christian Slanzi on 21.11.20.
//

public protocol Dated {
    var date: Date { get }
}

public extension Array where Element: Dated {
    func groupedBy(_ dateComponents: Set<Calendar.Component>) -> [Date: [Element]] {
        let initial: [Date: [Element]] = [:]
        let groupedByDateComponents = reduce(into: initial) { acc, cur in
            let components = Calendar.current.dateComponents(dateComponents, from: cur.date)
            let date = Calendar.current.date(from: components)!
            let existing = acc[date] ?? []
            acc[date] = existing + [cur]
        }
        
        return groupedByDateComponents
    }
}
