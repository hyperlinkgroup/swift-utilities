//
//  Date.swift
//
//
//  Created by Malte Schoppe on 28.09.21.
//

import Foundation

// MARK: - Accessors

extension Date {
    public var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    public var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    public var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    public var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    public func getComponents() -> (year: Int, month: Int, day: Int, hour: Int, minute: Int) {
        let year = Calendar.current.component(.year, from: self)
        let month = Calendar.current.component(.month, from: self)
        let day = Calendar.current.component(.day, from: self)
        let hour = Calendar.current.component(.hour, from: self)
        let minute = Calendar.current.component(.minute, from: self)
        
        return (year: year, month: month, day: day, hour: hour, minute: minute)
    }
}


// MARK: - Start + End

extension Date {
    public var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    public var endOfDay: Date? {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)
    }
    
    public var startOfWeek: Date? {
        Calendar.current.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date
    }
    
    public var endOfWeek: Date? {
        guard let startOfWeek else { return nil }
        var components = DateComponents()
        components.weekOfYear = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfWeek)
    }
    
    public var startOfMonth: Date? {
        Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))
    }
    
    public var endOfMonth: Date? {
        guard let startOfMonth else { return nil }
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfMonth)
    }
}


// MARK: - Init

extension Date {
    
    public init?(isoString: String) {
        guard let date = ISO8601DateFormatter().date(from: isoString) else {
            return nil
        }
        self = date
    }
    
    /**
     Datum erstellen aus einzelnen Werten.
     */
    public init?(day: Int, month: Int, year: Int, hour: Int = 0, minute: Int = 0) {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .current
        calendar.locale = .current
        
        let components = DateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: 0)
        
        guard components.isValidDate(in: calendar),
              let date = calendar.date(from: components) else {
            // Hier könnte ein Error geworfen werden, wenn bei der Integration was schief läuft
            // Aktuell wir dann immer Date() als Fallback genommen
            // Das mit einem guard zu sichern ist auch nicht gut, bevor Code nicht ausgeführt wird
            return nil
        }
        
        self = date
    }
    
    
    /**
     Erstellt einen Datumswert pro Tag bis zum angegebenen Datum
     
     - Parameter until: Endzeitpunkt
     
     - Returns: Array mit Daten
     */
    public func createDates(until endDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = self
        
        while date <= endDate {
            dates.append(date)
            
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            
            date = newDate
        }
        
        return dates
    }
}


// MARK: - Formatting

extension Date {
    /**
     Entfernung der Uhrzeit bei einem Datum.
     */
    public var removeTimeStamp: Date {
        if let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) {
            return date
        } else {
            return self
        }
    }
    
    public func dateFormat(format f: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = f
        dateFormatter.locale = Locale(identifier: Locale.preferredLanguages.first ?? "en_US")
        return dateFormatter.string(from: self)
    }
    
    
    public func getTimeString() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        let dateFormat = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: .current)  // If an "a" exists in this "j"-template, than it is in the 12h format
        
        let string = dateFormatter.string(from: self)
        
        if dateFormat?.range(of: "a") == nil && Locale.current.languageCode == "de" {
            return string // TODO: Localization
            //            return String.localizedStringWithFormat(Strings.oClock, string)
        } else {
            return string
        }
    }
    
    public func getDateString() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: self)
    }
    
    /**
     Datum formatieren in bestimmten Stil.
     
     Es kann entweder nur das Datum, nur die Uhrzeit oder beides ausgegeben werden. Der Standard ist bei beiden .none, weswegen eins von beiden überschrieben werden muss.
     
     - Parameter dateStyle: Stil des Datums (optional)
     - Parameter timeStyle: Stil der Uhrzeit (optional)
     
     - Returns: Text mit formatiertem Datum
     */
    public func withStyle(dateStyle: DateFormatter.Style = .none, timeStyle: DateFormatter.Style = .none) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        
        return dateFormatter.string(from: self)
    }
    
    /**
     Datum formatieren in bestimmtem Format.
     
     Diese Formatierung ist nur in bestimmten Fällen empfohlen, da diese nicht lokalisiert ist.
     
     - Parameter format: String mit Formatierung
     
     - Returns: Text mit formatiertem Datum
     */
    public func withFormat(format: String) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        
        return dateFormatter.string(from: self)
    }

    public func getWeekday() -> String {
        DateFormatter().weekdaySymbols[self.weekday - 1]
    }
}


// MARK: - Modification, Calculation

extension Date {
    public var dayBefore: Date {
        let prevDay = addDay(diff: -1).startOfDay
        if daysBetween(date: prevDay) > 1 {
            // one day per year has 25 hours (somewhere in October) and we need to catch it here
            return prevDay.addDay(diff: 1).startOfDay
        }
        return prevDay
    }
    public var dayAfter: Date {
        let nextDay = addDay(diff: 1).startOfDay
        if nextDay == self.startOfDay {
            // one day per year has 23 hours (somewhere in March) and we need to catch it here
            return addDay(diff: 2).startOfDay
        }
        return nextDay
    }
    
    public func addDay(diff: Int) -> Date {
        guard let date = Calendar.current.date(byAdding: .day, value: diff, to: self) else {
            fatalError("could not add \(diff) to \(self)")
        }
        return date
    }
    
    public func daysBetween(date d: Date) -> Int {
        var calendar = Calendar.current
        if let timeZone = TimeZone(identifier: "UTC") {
            calendar.timeZone = timeZone
        }
        if let diff = calendar.dateComponents([.day], from: self, to: d).day {
            return abs(diff)
        }
        return 0
    }
    
    public func getSeconds(to secondDate: Date) -> Double? {
        let diffComponents = Calendar.current.dateComponents([.nanosecond], from: self, to: secondDate)
        
        if let differenceInNanoseconds = diffComponents.nanosecond {
            return Double(differenceInNanoseconds).nanosecondsToSeconds()
        } else {
            return nil
        }
    }
    
    
    /**
     Wochentage zur Weiterberechnung auf US-Werte setzen.
     
     Wenn die Woche als Array von Montag (0) bis Sonntag (6) geht, werden die Werte zur Rechnung im Calendar auf die US-Werte gesetzt: Sonntag wird 0, Montag wird 1 usw.
     
     - Parameter weekday: Wochentag aus Array
     
     - Returns: Wochentag im US-Format
     */
    public func setWeekdayToUSDefault(_ weekday: Int) -> Int {
        weekday == 6 ? 1 : weekday + 2
    }
    
}


// MARK: - Compare

extension Date {
    
    
    /**
     Überprüfen, wie groß der Unterschied des gegebenen Datums im Vergleich zum heutigen Datum ist.
     
     - Returns: Wahr oder falsch
     */
    public func isEqual(_ date: Date) -> Bool {
        let dateComparisonForHighlight = Calendar.current.compare(date, to: self, toGranularity: .day)
        return dateComparisonForHighlight == .orderedSame
    }
    
    /**
     Überprüfen, ob Datum zwischen zwei anderen Daten liegt.
     */
    public func isBetween(date date1: Date, andDate date2: Date) -> Bool {
        date1.compare(self).rawValue * self.compare(date2).rawValue >= 0
    }
    
    
    
    /**
     Vergleichen von zwei Daten und Ausgabe der Differenz in Tagen.
     
     Eine Ausgabe von 0 ist gleicher Tag. Ein negativer Wert bedeutet, dass das Vergleichsdatum später ist.
     
     - Parameter date: Datum, mit dem verglichen werden soll
     
     - Returns: Wert des Vergleichs
     */
    public func compareTo(date: Date) -> Int {
        let dateOne = Calendar.current.startOfDay(for: self)
        let dateTwo = Calendar.current.startOfDay(for: date)
        
        return Calendar.current.dateComponents([.day], from: dateOne, to: dateTwo).day ?? 0
    }
}


// MARK: - Encoding

extension Date {
    public func toISO() -> String {
        ISO8601DateFormatter().string(from: self)
    }
}
