//
//  ParksView.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/10/22.
//

import SwiftUI
import MapKit

struct ParksView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(red: 110/255, green: 136/255, blue: 152/255, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
    }
    
    var newParksModel = NewParksModel()
    
    @State var parks: Parks?
    
    var body: some View {
        
        //Calls API to generate list of parks, else ProgressView
        
        if let parks = parks {
            
            NewParksView(parks: parks)
            
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

struct ParksView_Previews: PreviewProvider {
    static var previews: some View {
        ParksView()
    }
}
