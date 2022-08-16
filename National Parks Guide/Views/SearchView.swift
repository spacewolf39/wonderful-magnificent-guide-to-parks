//
//  SearchView.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/21/22.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchTerm: String = ""
    
    @StateObject var searchModel = SearchModel()
    
    let blueMainColor = Color(red: 110/255, green: 136/255, blue: 152/255)
    let darkGreen = Color(red: 21/255, green: 71/255, blue: 52/255)
    
    var body: some View {
        
        let searchTermUsed = searchTerm.replacingOccurrences(of: " ", with: "&")
        
        ZStack {blueMainColor
            
            VStack {
                                
                HStack {
                    
                    Image(systemName: "magnifyingglass").foregroundColor(darkGreen)
                    
                    TextField("Search by Park Name, Activity, Topic, etc",
                              text: $searchTerm
                    )
                    .font(.title2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onSubmit {
                        searchModel.fetchSearch(searchTerm: searchTermUsed)
                    }
                }.padding()
                
                List{
                    ForEach(searchModel.parks?.data ?? [], id: \.self) { park in
                        
                        NavigationLink("\(park.fullName)", destination: NewDestinationView(park: park, parkCode: park.parkCode))
                    }
                }
            }
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
