//
//  locationMapView.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/13/22.
//

import SwiftUI
import CoreLocationUI
import MapKit

struct locationMapView: View {
    
    var parks: Parks
    var park: Parks.dataResponse
    
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            //creates map and places annotations with navigation links to detailed view of park
            
            Map(coordinateRegion: $locationManager.region, showsUserLocation: true, annotationItems: parks.data) { park in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: Double(park.latitude) ?? 0, longitude: Double(park.longitude) ?? 0)) {
                    
                    PlaceAnnotationView(title: park.fullName, park: park)
                    
                }
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            VStack {
                if locationManager.location != nil {} else {
                    if locationManager.isLoading {
                        ProgressView()
                    }
                }
                
                //location button, finds user's location when tapped
                
                LocationButton {
                    locationManager.requestLocation()
                }
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .cornerRadius(30)
                .symbolVariant(.fill)
                .foregroundColor(.white)
                .labelStyle(.iconOnly)
                .offset(x: 160)
                Spacer()
            }
        }
    }
}


struct locationMapView_Previews: PreviewProvider {
    static var previews: some View {
        locationMapView(parks: previewParks, park: previewParks.data[0])
    }
}
