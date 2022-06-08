//
//  File.swift
//  CustomCalendar
//
//  Created by juntaek.oh on 2022/05/30.
//

import Foundation

class CalendarDateFormatter {
    private let calendar = Calendar.current
    private let dateFormatter = DateFormatter()
    private var nowCalendarDate = Date()
    
    init() {
        self.configureCalendar()
    }
    
    func getYearMonthText() -> String {
        let yearMonthText = self.dateFormatter.string(from: self.nowCalendarDate)
        
        return yearMonthText
    }
    
    func updateCurrentMonthDays() -> [String] {
        var days = [String]()
        
        let startDayOfWeek = self.getStartingDayOfWeek()
        let totalDaysOfMonth = startDayOfWeek + self.getEndDateOfMonth()
        
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
    
    func getStartingDayOfWeek() -> Int {
        return self.calendar.component(.weekday, from: self.nowCalendarDate) - 1
    }
    
    func getEndDateOfMonth() -> Int {
        return self.calendar.range(of: .day, in: .month, for: self.nowCalendarDate)?.count ?? 0
    }
    
    func configureCalendar() {
        let components = self.calendar.dateComponents([.year, .month], from: Date())
        self.nowCalendarDate = self.calendar.date(from: components) ?? Date()
        self.dateFormatter.dateFormat = "yyyy년 MM월"
    }
}
