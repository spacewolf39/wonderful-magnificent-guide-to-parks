//
//  CampgroundView.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/19/22.
//

import SwiftUI

struct CampgroundView: View {
    
    @StateObject var campgroundsModel = CampgroundsModel()
    
    @Binding var parkCode: String
    
    var body: some View {

        List {
            
            ForEach(campgroundsModel.campgrounds?.data ?? [], id: \.self) { camp in
                
                
                NavigationLink("\(camp.name)", destination: LoadingView())
                
            }
            
        }.onAppear(){

            campgroundsModel.fetchCampgrounds(parkCode: parkCode)
    }

}

struct CampgroundView_Previews: PreviewProvider {
    static var previews: some View {
        
        CampgroundView(parkCode: .constant("acad"))
    }
}

}
