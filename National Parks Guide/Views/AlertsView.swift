//
//  AlertsView.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/24/22.
//

import SwiftUI

struct AlertsView: View {
    
    var alerts: Alerts
    
    let darkGreen = Color(red: 21/255, green: 71/255, blue: 52/255)
    let softBlue = Color(red: 110/255, green: 136/255, blue: 152/255)
    
    var body: some View {
                
        HStack (alignment: .center, spacing: 60) {
                
                ForEach(alerts.data, id: \.self) { alert in
                    
                    VStack {
                        
                        ZStack (alignment: .top) {
                            
                            RoundedRectangle(cornerRadius: 15).fill(Color(hue: 1.0, saturation: 0.0, brightness: 0.971)).frame(width: 300, height: 400)
                            
                            VStack {
                                
                                ZStack {
                                    
                                    Rectangle().fill(LinearGradient(gradient: Gradient(colors: [.gray, softBlue]), startPoint: .top, endPoint: .bottom)).frame(width: 300, height: 200).offset(y: -10).cornerRadius(15, corners: [.topLeft, .topRight])
                        
                                    Text(alert.title).fontWeight(.bold).font(.title).foregroundColor(Color.white).frame(width: 280, height: 160)
                                    
                                }.offset(y: -15)
                                
                                VStack {
                                    
                                    if alert.url != "" {
                        
                                        Text(alert.description).frame(width: 280, height: 150).foregroundColor(Color.black)
                                    
                                        Link("Read More", destination: URL(string: alert.url) ?? URL(string: "none")!)
                                        
                                    } else {
                                        
                                        Text(alert.description).frame(width: 280, height: 180).foregroundColor(Color.black)
                                        
                                    }
                                    
                                }.offset(y: -20)
                            
                            }.padding()
                        }
                        
                    }.frame(width: 250, height: 300)
                    
                }
                
            }.modifier(ScrollingHStackModifier(items: alerts.data.count, itemWidth: 250, itemSpacing: 60))
        
    }
}

struct AlertsView_Previews: PreviewProvider {
    static var previews: some View {
        AlertsView(alerts: previewAlerts)
    }
}
