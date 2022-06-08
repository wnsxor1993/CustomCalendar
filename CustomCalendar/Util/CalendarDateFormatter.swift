//
//  File.swift
//  CustomCalendar
//
//  Created by juntaek.oh on 2022/05/30.
//

import Foundation

struct CalendarDateFormatter {
    
    private let dateFormatter = DateFormatter()
    private var calendarComponent: Calendar?
    
    init() {
        self.configureDateFormatter()
    }
    
    mutating func setCalendarComponent(calendar: Calendar) {
        self.calendarComponent = calendar
    }
    
    func getYearMonthText(calendarDate: Date) -> String {
        let yearMonthText = self.dateFormatter.string(from: calendarDate)
        
        return yearMonthText
    }
    
    func updateCurrentMonthDays(calendarDate: Date) -> [String] {
        var days = [String]()
        
        let startDayOfWeek = self.getStartingDayOfWeek(date: calendarDate)
        let totalDaysOfMonth = startDayOfWeek + self.getEndDateOfMonth(date: calendarDate)
        
        for day in 0..<totalDaysOfMonth {
            if day < startDayOfWeek {
                days.append("")
            } else {
                days.append("\(day - startDayOfWeek + 1)")
            }
        }
        
        return days
    }
}

private extension CalendarDateFormatter {
    
    func getStartingDayOfWeek(date: Date) -> Int {
        guard let calendar = calendarComponent else { return 0 }
        return calendar.component(.weekday, from: date) - 1
    }
    
    func getEndDateOfMonth(date: Date) -> Int {
        guard let calendar = calendarComponent else { return 0 }
        return calendar.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    func configureDateFormatter() {
        self.dateFormatter.dateFormat = "yyyy년 MM월"
    }
}
