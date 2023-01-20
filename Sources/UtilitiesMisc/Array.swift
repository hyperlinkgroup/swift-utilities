//
//  Array.swift
//  
//
//  Created by Kevin Waltz on 26.08.21.
//

import Foundation

public extension Array {
    /**
     Get the middle element of an array.
     */
    public var middle: Element? {
        guard !self.isEmpty else { return nil }
        
        let middleIndex = (count > 1 ? count - 1 : count) / 2
        return self[middleIndex]
    }
    
    public subscript (randomPick value: Int) -> [Element] {
        var copy = self
        
        for i in stride(from: count - 1, to: count - value - 1, by: -1) {
            copy.swapAt(i, Int.random(in: 0..<i + 1))
        }
        
        return Array(copy.suffix(value))
    }
    
    public func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

extension Array where Element == Int {
    /// In calculation of the IQM, only the data between the first and third quartiles is used, and the lowest 25% and the highest 25% of the data are discarded.
    var interquartileMean: Element {
        let sortedArray = self.sorted()
        let Q1 = self.count * 1/4 // swiftlint:disable:this identifier_name
        let Q3 = self.count * 3/4 // swiftlint:disable:this identifier_name
        let interquartileRange = Array(sortedArray[Q1..<Q3])
        let decimalAverage = Float(interquartileRange.reduce(0, +)) / Float(interquartileRange.count)
        return Element(decimalAverage.rounded())
    }
}
