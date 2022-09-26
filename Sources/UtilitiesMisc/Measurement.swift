//
//  Measurement.swift
//  
//
//  Created by Kevin Waltz on 13.07.22.
//

import Foundation

extension Measurement {
    func unitString() -> String {
        self.unit.symbol
    }
    
    func valueString(roundedTo: Int = 2) -> String {
        roundedTo == 0 ? self.value.clean : "\(self.value.decimalRounded(to: roundedTo))"
    }
    
    func valueUnitString(roundedTo: Int = 2) -> String {
        valueString(roundedTo: roundedTo) + self.unit.symbol
    }
}
