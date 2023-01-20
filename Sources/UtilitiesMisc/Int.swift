//
//  File.swift
//  
//
//  Created by Anna Münster on 19.01.23.
//

import Foundation

public extension Int {
    public func concatenateDecimalDigits(in other: Int) -> Int {
        let scale: Int
        
        switch other {
        case 0...9:
            scale = 10
        case 10...99:
            scale = 100
        case 100...999:
            scale = 1000
        default:
            scale = 0
        }
        
        return self * scale + other
    }
}
