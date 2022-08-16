//
//  EventDetailView.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/28/22.
//

import SwiftUI
import CachedAsyncImage

struct EventDetailView: View {
    
    var park: Parks.dataResponse
    
    var event: Events.dataResponse
    
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

                    Text(event.title).fontWeight(.bold).font(.title).foregroundColor(Color.white).offset(y: 50)

                }

                ZStack {

                    Rectangle().fill(Color(red: 110/255, green: 136/255, blue: 152/255)).frame(width: geo.size.width, height: 60) //rectangle for buttons
                    
                    Text(event.category).fontWeight(.bold).font(.title).foregroundColor(Color.white)
                    
                }.offset(y: -10) //ZStack "EVENT"
                
            }.offset(y: -25) //ZStack Image and title
            
            VStack (spacing: 20) {
                
                VStack {
                    
                    Text("Description:").fontWeight(.bold).frame(width: geo.size.width * 0.95, alignment: .leading)
                    
                    Text(strip(string: event.description)).lineLimit(nil)
                    
                }
                
                Rectangle()
                    .frame(width: geo.size.width * 0.95, height: 2)
                    .foregroundColor(Color.yellow)
                
                VStack {
                    
                    Text("Date and Time:").fontWeight(.bold).frame(width: geo.size.width * 0.95, alignment: .leading)
                    
                    if event.datestart != event.dateend {
                        
                        Text("\(event.datestart) - \(event.dateend)")
                        
                    } else {
                        Text(event.datestart)
                    }
                    
                    if event.times != [] {
                        
                        ForEach(event.times, id: \.self) {time in
                            Text("\(time.timestart) - \(time.timeend)")
                        }
                        
                    }
                    
                }
                
                Rectangle()
                    .frame(width: geo.size.width * 0.95, height: 2)
                    .foregroundColor(Color.yellow)
                
                if event.infourl != "" {
                    Link("Read More", destination: URL(string: event.infourl) ?? URL(string: "none")!)
                }
                
            }.frame(width: geo.size.width * 0.95).offset(y: -30)
            
        }
            
        }.edgesIgnoringSafeArea(.top)
        
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailView(park: previewParks.data[0], event: previewEvents.data[0])
    }
}
