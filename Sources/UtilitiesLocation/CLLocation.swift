//
//  CLLocation.swift
//  
//
//  Created by Malte Schoppe on 01.04.22.
//

import Foundation
import CoreLocation


extension CLLocation {
    
    func degreesToRadians(degrees: Double) -> Double {
        degrees * .pi / 180.0
    }
    
    func radiansToDegrees(radians: Double) -> Double {
        radians * 180.0 / .pi
    }

    func getBearingTo(_ location: CLLocation) -> Double {
        let firstLatitude = degreesToRadians(degrees: self.coordinate.latitude)
        let firstLongitude = degreesToRadians(degrees: self.coordinate.longitude)

        let secondLatitude = degreesToRadians(degrees: location.coordinate.latitude)
        let secondLongitude = degreesToRadians(degrees: location.coordinate.longitude)

        let differenceLongitude = secondLongitude - firstLongitude

        let yValue = sin(differenceLongitude) * cos(secondLatitude)
        let xValue = cos(firstLatitude) * sin(secondLatitude) - sin(firstLatitude) * cos(secondLatitude) * cos(differenceLongitude)
        let radiansBearing = atan2(yValue, xValue)

        // Convert it to compass bearings (360° instead of +/- 180°)
        return (radiansToDegrees(radians: radiansBearing) + 360).truncatingRemainder(dividingBy: 360)
    }
}
