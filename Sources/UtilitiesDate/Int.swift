//
//  Int.swift
//  
//
//  Created by Malte Schoppe on 24.02.22.
//

import Foundation

public extension Int {
    func createTimeString() -> String {
        let minute = self / 60 % 60
        let second = self % 60
        
        return String(format: "%02i:%02i", minute, second)
    }
    
    init(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        self.init(dateFormatter.string(from: date))!
    }

    func toDateFromUTC() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.date(from: String(self))
    }
    
    func setWeekdayToUSDefault() -> Int {
        self == 6 ? 0 : self + 1
    }
}
