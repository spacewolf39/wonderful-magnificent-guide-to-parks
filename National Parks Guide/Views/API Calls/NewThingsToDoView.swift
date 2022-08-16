//
//  NewThingsToDoView.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/22/22.
//


//Purpose of this view is to use Async await for API request so I can use progress view.
import SwiftUI

struct NewThingsToDoView: View {
    
    @State var thingsToDo: ThingsToDo?
    var thingsToDoModel = NewThingsToDoModel()
    
    var park: Parks.dataResponse
    
    
    var parkCode: String
    
//    let darkGreen = Color(red: 21/255, green: 71/255, blue: 52/255)
    
    var body: some View {
        
        if thingsToDo != nil {
            ThingsToDoView(thingsToDo:thingsToDo ?? previewThingsToDo, parkCode: park.parkCode)
        } else {
            ProgressView("Fetching Activities")
                .task {
                    do {
                        thingsToDo = try await thingsToDoModel.getThingsToDo(parkCode: parkCode)
                    } catch {
                        print("Error getting parks: \(error)")
                    }
                    
                }
        }
    }
    
}

struct NewThingsToDoView_Previews: PreviewProvider {
    static var previews: some View {
        NewThingsToDoView(thingsToDo: previewThingsToDo, park: previewParks.data[0], parkCode: "acad")
    }
}
