//
//  ContentView.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/10/22.
//

import SwiftUI

struct ContentView: View {
    
    let darkGreen = Color(red: 21/255, green: 71/255, blue: 52/255)
    let softBlue = Color(red: 110/255, green: 136/255, blue: 152/255)
    
    var parks: Parks
    var park: Parks.dataResponse
    
    var newsModel = NewsModel()
    var alertsModel = AlertsModel()
    
    @State var news: News?
    @State var alerts: Alerts?
    
    var body: some View {
        
        GeometryReader { geo in
            
            NavigationView {
                
                ScrollView {
                    
                    VStack (spacing: 50) {
                        
                        ZStack {
                            
                            //Header Image
                            
                            Image("glacier")
                            
                            VStack (spacing: 50) {
                                
                                Text("Welcome to the Wonderful Magnificent Guide to Parks!").fontWeight(.bold).font(.largeTitle).frame(width: geo.size.width * 0.95, alignment: .leading).foregroundColor(Color.white)
                                
                                // Discover parks button
                                Button(action: {}) {
                                    
                                    NavigationLink(destination: MenuView(parks: parks, park: park)) {
                                        HStack {
                                            Text("Discover Parks")
                                            Image(systemName: "chevron.right")
                                        }
                                    }
                                    
                                    
                                }.font(.system(size: 30, weight: .bold)).padding(17.0).background(softBlue).clipShape(Capsule()).font(.largeTitle).foregroundColor(.white)
                                
                            }
                        }
                        
                        //NEWS RELEASES SECTION
                        
                        Text("News Releases")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(width: geo.size.width * 0.95, alignment: .leading)
                        
                        if let news = news {
                            NewsReleasesView(news: news).padding()
                        } else {
                            ProgressView("Fetching Alerts")
                                .task {
                                    do {
                                        news = try await newsModel.getArticles()
                                    } catch {
                                        print("Error getting parks: \(error)")
                                    }
                                    
                                }
                        }
                        
                        //Alerts Section
                        
                        Text("Alerts")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(width: geo.size.width * 0.95, alignment: .leading)
                        
                        if let alerts = alerts {
                            AlertsView(alerts: alerts).padding()
                        } else {
                            ProgressView("Fetching Articles")
                                .task {
                                    do {
                                        alerts = try await alertsModel.getAlerts()
                                    } catch {
                                        print("Error getting parks: \(error)")
                                    }
                                    
                                }
                            
                        }
                        
                        //INFORMATION
                        
                        Text("All data provided by National Parks Service")
                        
                        
                    }
                    
                }.ignoresSafeArea()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(parks: previewParks, park: previewParks.data[0], alerts: previewAlerts)
    }
}
