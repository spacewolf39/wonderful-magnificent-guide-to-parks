//
//  LocationManager.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/13/22.
//

import Foundation
import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading = false
    @Published var region = MKCoordinateRegion(
           center: CLLocationCoordinate2D(latitude: 40.007367, longitude: -98.350487),
           span: MKCoordinateSpan(latitudeDelta: 40, longitudeDelta: 40)
       )

    
    override init() {
        super.init()
        locationManager.delegate = self
    }

    func requestLocation() {
        isLoading = true
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.first else { return }
            
            DispatchQueue.main.async {
                self.location = location.coordinate
                self.region = MKCoordinateRegion(
                    center: location.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                )
            }
    }

    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location", error)
        isLoading = false
        }
    
    }





