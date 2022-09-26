//
//  Double.swift
//  
//
//  Created by Kevin Waltz on 23.08.21.
//

import Foundation
#if !os(macOS)
import UIKit
#endif

extension Double {
    /**
     Cast the given double to an int to remove decimal places.
     - Returns: String with the int
     */
    var clean: String {
        "\(Int(self))"
    }
    
    /**
     Rounding double to specified number of decimals.
     - Parameter places: decimal places
     */
    func decimalRounded(to places: Int) -> Double {
        let divisor = pow(10, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    /**
     Return a radiant value for a given degree.
     - returns: The radiant as a CGFloat value
     */
    func radiantValue() -> CGFloat {
        CGFloat(self  * .pi / 180)
    }
}
