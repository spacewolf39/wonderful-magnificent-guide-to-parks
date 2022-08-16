//
//  ThingsToDoView.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/19/22.
//

import SwiftUI
import CachedAsyncImage

struct ThingsToDoView: View {
    
    var thingsToDo: ThingsToDo
    
    var parkCode: String
    
    let darkGreen = Color(red: 21/255, green: 71/255, blue: 52/255)
    
    var body: some View {
        
        if thingsToDo.data == [] {

                Text("No Activities Found")
            
        } else {
        
        List{
            
            ForEach(thingsToDo.data, id: \.self) { toDo in
                
                HStack {
                    
                    CachedAsyncImage(url: URL(string: "\(toDo.images[0].url)")) {
                        image in image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 70)
                      
  
                                
                    } placeholder: {
                        ZStack {
                            Rectangle().fill(LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .top, endPoint: .bottom)).frame(width: 100, height: 70)
                            ProgressView()
                            }
                    }
                
                
                    NavigationLink("\(toDo.title)", destination: NewActivityView(toDo: toDo)) //To pass the toDo data to the next view, insert it as a parameter -> now look at NewActivityView, we say var toDo: ThingsToDo.dataResponse
                
                }
                
            }
        
            
        }.navigationTitle("Activities")
            
        }
        
    }
        
    
    
    struct ThingsToDoView_Previews: PreviewProvider {
        static var previews: some View {
            ThingsToDoView(thingsToDo: previewThingsToDo, parkCode: "acad")
        }
    }
    
}


