//
//  mapView.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/12/22.
//


import SwiftUI
import MapKit

struct mapView: View {
    
   @State var parks: Parks?
    var park: Parks.dataResponse
    
    var newParksModel = MapParksModel()
    
    var body: some View {
        
        //API call for parks, shows progressview while fetching
        
        if let parks = parks {
            locationMapView(parks: parks, park: park)
        } else {
            ProgressView("Finding Parks")
                .task {
                    do {
                        parks = try await newParksModel.getParks()
                    } catch {
                        print("Error getting parks: \(error)")
                    }
                    
                }
        }
        
    }
}

struct mapView_Previews: PreviewProvider {
    static var previews: some View {
        mapView(parks: previewParks, park: previewParks.data[0])
    }
}
