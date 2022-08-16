//
//  MenuView.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/13/22.
//

import SwiftUI

struct MenuView: View {
    
    let parkLogo = Image(systemName: "leaf")
    let mapLogo = Image(systemName: "map")
    let locationLogo = Image(systemName: "location")
    var parks: Parks
    var park: Parks.dataResponse
    @State private var selection = 1
    
    var body: some View {
        
        //creates navigation tabs at the bottom of the screen
        
        TabView (selection: $selection) {
            
            ParksView()
                .tabItem() {
                    Image(systemName: "leaf")
                    Text("View Parks")
                }.tag(1)

            mapView(park: park)
                .tabItem() {
                    Image(systemName: "map")
                    Text("View Map")
                }.tag(2)
            
            SearchView()
                .tabItem() {
                    Image(systemName: "magnifyingglass")
                    Text("Search Parks")
                }.tag(3)
            
        }.accentColor(Color(red: 21/255, green: 71/255, blue: 52/255))
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(parks: previewParks, park: previewParks.data[0])
    }
}
