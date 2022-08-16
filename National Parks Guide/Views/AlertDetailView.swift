//
//  AlertDetailView.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/29/22.
//

import SwiftUI
import MapKit
import CachedAsyncImage

struct AlertDetailView: View {
    
    var alert: Alerts.dataResponse
    
    var park: Parks.dataResponse
    
    var body: some View {
        
        GeometryReader { geo in
        
        ScrollView {
            
            VStack {

                ZStack {

                    CachedAsyncImage(url: URL(string: "\(park.images[0].url)")) {
                        image in image
                            .resizable()
                            .frame(width: geo.size.width, height: 300).edgesIgnoringSafeArea(.top)

                    } placeholder: {

                        ZStack {

                            Rectangle().fill(LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom)).frame(width: geo.size.width, height: 300).edgesIgnoringSafeArea(.top)

                            LoadingView()

                        }
                    }

                    Rectangle().fill(Color.black.opacity(0.3)).frame(width: geo.size.width, height: 300).edgesIgnoringSafeArea(.top)

                    Text(alert.title).fontWeight(.bold).font(.title).foregroundColor(Color.white).offset(y: 50)

                }

                ZStack {

                    Rectangle().fill(Color(red: 110/255, green: 136/255, blue: 152/255)).frame(width: geo.size.width, height: 60) //rectangle for buttons
                    
                    Text(alert.category).fontWeight(.bold).font(.title).foregroundColor(Color.white)
                    
                }.offset(y: -10) //ZStack "EVENT"
                
            }.offset(y: -25) //ZStack Image and title
            
            VStack (spacing: 20) {
                
                VStack {
                    
                    Text("Description:").fontWeight(.bold).frame(width: geo.size.width * 0.95, alignment: .leading)
                    
                    Text(strip(string: alert.description)).lineLimit(nil)
                    
                }
                
                Rectangle()
                    .frame(width: geo.size.width * 0.95, height: 2)
                    .foregroundColor(Color.yellow)
                
                if alert.url != "" {
                    Link("Read More", destination: URL(string: alert.url) ?? URL(string: "none")!)
                }
                
            }.frame(width: geo.size.width * 0.95).offset(y: -30)
            
        }
            
        }.edgesIgnoringSafeArea(.top)
        
    }
}

struct AlertDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AlertDetailView(alert: previewAlerts.data[0], park: previewParks.data[0])
    }
}
