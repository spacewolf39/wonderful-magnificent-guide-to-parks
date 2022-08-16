//
//  NewParksView.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/22/22.
//

import SwiftUI

struct NewParksView: View {
    
    var parks: Parks
    
    let softBlue = Color(red: 110/255, green: 136/255, blue: 152/255)
    
    var body: some View {
        
        ZStack {softBlue

            VStack {
                
                //ganerates list of all parks and navigation links to the more detailed park view
                
                List{
                    ForEach(parks.data, id: \.self) { park in
                        
                        NavigationLink("\(park.fullName)", destination: NewDestinationView(park: park, parkCode: park.parkCode))
                    }
                }
            }
        }
    }
}

struct NewParksView_Previews: PreviewProvider {
    static var previews: some View {
        NewParksView(parks: previewParks)
    }
}
