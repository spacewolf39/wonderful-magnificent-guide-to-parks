//
//  PlaceAnnotationView.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/12/22.
//

import SwiftUI

struct PlaceAnnotationView: View {
    
    @State private var showTitle = true
    
    let title: String
//    let parkImage: String
    
    var park: Parks.dataResponse
    let softBlue = Color(red: 110/255, green: 136/255, blue: 152/255)
    var body: some View {
        
        VStack(spacing: 0) {
            
            //box with park name
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 10).fill(Color.white)
                
                NavigationLink("\(title)", destination: NewDestinationView(park: park, parkCode: park.parkCode))
                
            }.font(.callout)
                .foregroundColor(Color.black)
                .padding(5)
                .cornerRadius(10)
                .opacity(showTitle ? 0 : 1)
                .frame(width: 200)
                .padding(10)
            
            //Manually creating pin icon by stacking images
            
            ZStack {
                
                Circle()
                    .frame(width: 32, height: 32)
                
                Image(systemName: "mappin.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.red)
                
            }
            
            Image(systemName: "arrowtriangle.down.fill")
                .font(.caption)
                .foregroundColor(.red)
                .offset(x: 0, y: -5)
            
        //Shows the box with park name when pin is tapped
            
        }.onTapGesture {
            withAnimation(.easeInOut) {
                showTitle.toggle()
            }
        }
        
    }
    
    
    
    struct PlaceAnnotationView_Previews: PreviewProvider {
        static var previews: some View {
            PlaceAnnotationView(title: "title", park: previewParks.data[0])
        }
    }
    
}
