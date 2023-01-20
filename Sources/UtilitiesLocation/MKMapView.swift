//
//  MKMapView.swift
//  Quartermile
//
//  Created by Kevin Waltz on 26.08.21.
//

import Foundation
import MapKit

public extension MKMapView {
    /**
     Center the map to a specified location.
     
     - Parameters location: the location to be centered on
     - Parameters regionRadius: the radius to display around the location
     */
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 3000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
    
    /**
     Add an annotation with a title at a specific coordinate.
     
     - Parameters title: String to display below annotation
     - Parameters coordinate: Coordinate to display annotation at
     */
    func addPoint(title: String, coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.coordinate = coordinate
        addAnnotation(annotation)
    }
}

extension MKPointAnnotation {
    func location() -> CLLocation {
        CLLocation(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)
    }
}
