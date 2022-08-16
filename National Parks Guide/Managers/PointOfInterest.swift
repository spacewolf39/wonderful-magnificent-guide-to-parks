//
//  PointOfInterest.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/11/22.
//

import Foundation
import MapKit

//model for map annotations

struct PointOfInterest: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    
}
