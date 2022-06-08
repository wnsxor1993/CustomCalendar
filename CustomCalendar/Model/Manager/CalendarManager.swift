//
//  CalendarManager.swift
//  CustomCalendar
//
//  Created by juntaek.oh on 2022/06/08.
//

import Foundation

final class CalendarManager {
    
    private let calendar = Calendar.current
    private var nowCalendarDate = Date()
    private var calendarFormatter = CalendarDateFormatter()
    private(set) var yearMonths = [Date]()
    private(set) var monthDays = [[String]]()
    
    init() {
        self.setCalendar()
    }
    
    func getMonthsToString(section: Int) -> String {
        guard yearMonths.count > section else { return "" }
        
        let monthString = self.calendarFormatter.getYearMonthText(calendarDate: yearMonths[section])
        return monthString
    }
    
}

private extension CalendarManager {
    
    func setCalendar() {
        let components = self.calendar.dateComponents([.year, .month], from: Date())
        self.nowCalendarDate = self.calendar.date(from: components) ?? Date()
        self.calendarFormatter.setCalendarComponent(calendar: self.calendar)
        self.setYearMonth()
        self.setMonthDays()
    }
    
    func setYearMonth() {
        self.yearMonths.append(self.nowCalendarDate)
        
        for plusNum in 1...11 {
            let month = self.calendar.date(byAdding: .month, value: plusNum, to: nowCalendarDate)
            self.yearMonths.append(month ?? Date())
        }
    }
    
    func setMonthDays() {
        self.yearMonths.forEach {
            let days = self.calendarFormatter.updateCurrentMonthDays(calendarDate: $0)
            self.monthDays.append(days)
        }
    }
}
