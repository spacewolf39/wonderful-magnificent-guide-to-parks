//
//  EventsAPICall.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/28/22.
//

import SwiftUI

struct EventsAPICall: View {
    
    var park: Parks.dataResponse
    
    var parkEventsModel = ParkEventsModel()
    
    @State var events: Events?
    
    @Binding var parkCode: String
    
    
    var body: some View {
        
        if let events = events {
            
            EventsView(park: park, events: events)
            
        } else {
            
             ProgressView("Finding Events")
                .task {
                    do {
                        events = try await parkEventsModel.getEvents(parkCode: parkCode)
                    } catch {
                        print("Error getting parks: \(error)")
                    }
                }
        }
        
        
    }
}

struct EventsAPICall_Previews: PreviewProvider {
    static var previews: some View {
        EventsAPICall(park: previewParks.data[0], parkCode: .constant("acad"))
    }
}
