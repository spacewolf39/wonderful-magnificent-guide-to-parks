//
//  EventsView.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/28/22.
//

import SwiftUI

struct EventsView: View {
    
    var park: Parks.dataResponse
    
var events: Events
    
    var body: some View {
        
        if events.data != [] {
        
        List {
            ForEach(events.data, id: \.self) {event in
                NavigationLink(event.title, destination: EventDetailView(park: park, event: event))
            }
        }
            
        } else {
            Text("No Events Found")
        }
        
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView(park: previewParks.data[0], events: previewEvents)
    }
}
