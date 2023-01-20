//
//  Double.swift
//
//
//  Created by Kevin Waltz on 23.08.21.
//

import Foundation

public extension Double {
    /**
    Divide the nanoseconds by one billion to get the value in seconds.
     - returns: Value in seconds
     */
    func nanosecondsToSeconds() -> Double {
        self / 1000000000
    }
}
