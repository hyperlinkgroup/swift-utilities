//
//  String.swift
//
//
//  Created by Anna Münster on 05.10.18.
//  Copyright © 2018 spacesquad. All rights reserved.
//

import Foundation

public extension String {
    public func toDate(format f: String = "dd.MM.yyyy HH:mm") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = f
        // if the user has set its device preferences to 12hour-format, the dateFormatter is not able to work as defined so we need to set the posix-locale, a locale that's specifically designed to yield US English results regardless of both user and system preferences
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.date(from: self)
    }
    
    func setFormat() -> Date? {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter.timeZone = .current
        dateFormatter.locale = Locale.current
        
        return dateFormatter.date(from: self)
    }
}
