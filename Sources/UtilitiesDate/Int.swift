//
//  Int.swift
//  
//
//  Created by Malte Schoppe on 24.02.22.
//

import Foundation

extension Int {
    public func createTimeString() -> String {
        let minute = self / 60 % 60
        let second = self % 60
        
        return String(format: "%02i:%02i", minute, second)
    }
    
    public init(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        self.init(dateFormatter.string(from: date))!
    }

    public func toDateFromUTC() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.date(from: String(self))
    }
}
