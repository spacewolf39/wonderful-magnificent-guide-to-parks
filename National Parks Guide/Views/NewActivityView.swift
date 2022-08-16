//
//  NewActivityView.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/20/22.
//

import SwiftUI
import CachedAsyncImage

struct NewActivityView: View {
    
    var toDo: ThingsToDo.dataResponse
    
    let darkGreen = Color(red: 21/255, green: 71/255, blue: 52/255)
    
    @State var expand: Bool = false
    @State var expandTwo: Bool = false
    
    var body: some View {
            
            ZStack {
                
//                darkGreen.edgesIgnoringSafeArea(.bottom)
                
                GeometryReader { geo in
                    
                    ScrollView {
                        
                        VStack {
                            
                            ZStack {
                                
                                CachedAsyncImage(url: URL(string: "\(toDo.images[0].url)")) {
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
                                
                                Text(toDo.title).fontWeight(.bold).font(.title).foregroundColor(Color.white).offset(y: 50)
                                
                            }
                            
                            ZStack {
                                
                                Rectangle().fill(Color(red: 110/255, green: 136/255, blue: 152/255)).frame(width: geo.size.width, height: 60).offset(y: 20) //rectangle for buttons
                                
                                HStack {
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                    }) {
                                        
                                        NavigationLink(destination: getActivityFees(from: toDo)) {
                                            
                                            if toDo.doFeesApply == "true" {
                                                VStack (spacing: 8) {
                                                    Image(systemName: "dollarsign.circle").padding(12).background(Color(red: 21/255, green: 71/255, blue: 52/255))
                                                        .clipShape(Circle()).font(.title)
                                                        .shadow(radius: 7)
                                                    
                                                    Text("Fees")
                                                }.foregroundColor(Color.white)
                                            } else if toDo.doFeesApply == "false" {
                                                VStack {
                                                    ZStack {
                                                        Image(systemName: "dollarsign.circle")
                                                        Image(systemName: "circle.slash")
                                                    }.padding(12).background(Color(red: 21/255, green: 71/255, blue: 52/255))
                                                        .clipShape(Circle()).font(.title)
                                                        .shadow(radius: 7)
                                                    
                                                    Text("Fees")
                                                }.foregroundColor(Color.white)
                                                
                                            }
                                            
                                            
                                        }
                                        
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                    }) {
                                        
                                        NavigationLink(destination: getPetDesc(from: toDo)) {
                                            
                                            if toDo.arePetsPermitted == "true" {
                                                VStack (spacing: 8) {
                                                    Image(systemName: "pawprint.circle").padding(12).background(Color(red: 21/255, green: 71/255, blue: 52/255)).font(.title)
                                                        .clipShape(Circle())
                                                        .shadow(radius: 7)
                                                    
                                                    Text("Pets")
                                                }.foregroundColor(Color.white)
                                            } else if toDo.arePetsPermitted == "false" {
                                                VStack {
                                                    ZStack {
                                                        Image(systemName: "pawprint.circle")
                                                        Image(systemName: "circle.slash")
                                                    }.padding(12).background(Color(red: 21/255, green: 71/255, blue: 52/255))
                                                        .clipShape(Circle()).font(.title)
                                                        .shadow(radius: 7)
                                                    
                                                    Text("Pets")
                                                }.foregroundColor(Color.white)
                                            }
                                            
                                        }
                                        
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                    }) {
                                        
                                        NavigationLink(destination: getBookingDesc(from: toDo)) {
                                            
                                            if toDo.isReservationRequired == "true" {
                                                VStack (spacing: 8) {
                                                    Image(systemName: "book").padding(12).background(Color(red: 21/255, green: 71/255, blue: 52/255))
                                                        .clipShape(Circle()).font(.title)
                                                        .shadow(radius: 7)
                                                    
                                                    Text("Booking")
                                                }.foregroundColor(Color.white)
                                            } else if toDo.isReservationRequired == "false" {
                                                VStack {
                                                    ZStack {
                                                        Image(systemName: "book.circle")
                                                        Image(systemName: "circle.slash")
                                                    }.padding(12).background(Color(red: 21/255, green: 71/255, blue: 52/255))
                                                        .clipShape(Circle()).font(.title)
                                                        .shadow(radius: 7)
                                                    
                                                    Text("Booking")
                                                }.foregroundColor(Color.white)
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                    
                                    Spacer()
                                    
                                    
                                }.offset(y: 2)
                                
                            }.offset(y: -50) //ZStack Buttons and Rectangle
                            
                            VStack (spacing: 20){

                                if toDo.shortDescription.count < 100 {
                                    Text(toDo.shortDescription).fontWeight(.bold).font(.title)
                                } else {
                                    Text(toDo.shortDescription).fontWeight(.bold).font(.title3)
                                }
                                
                                if toDo.location != "" {
                                
                                    Text("Located at \(toDo.location)").frame(width: geo.size.width * 0.95, alignment: .leading)
                                    
                                }
                                
                                if toDo.longDescription != "" {
                                
                                Rectangle()
                                    .frame(height: 2)
                                    .foregroundColor(Color.yellow)
                                    
                                // Description and highlights expandable section, uses     @State var expand: Bool = false

                                
                                Text("Description and Highlights").fontWeight(.bold).frame(width: geo.size.width * 0.95, alignment: .leading)
                                
                                VStack {
                                    Text(strip(string:toDo.longDescription)).frame(width: geo.size.width * 0.95, height: expand ? nil : 200)
                                    Button("Read More...") {
                                                   withAnimation {
                                                       expand.toggle()
                                                   }
                                               }
                                               .buttonStyle(.plain)
                                }
                                    
                                }
                                
                                if toDo.accessibilityInformation != "" {
                                
                                Rectangle()
                                    .frame(height: 2)
                                    .foregroundColor(Color.yellow)
                                
                                Text("Accessibility Information").fontWeight(.bold).frame(width: geo.size.width * 0.95, alignment: .leading)
                                
                                Text(strip(string:toDo.accessibilityInformation))
                                    
                                }
                                
                            }.lineLimit(nil).frame(width: geo.size.width * 0.95).offset(y: -30).lineSpacing(5)
                                
                        }
                        
                    }.ignoresSafeArea().frame(width: geo.size.width)
                    
                }
            }
    }
}

struct NewActivityView_Previews: PreviewProvider {
    static var previews: some View {
        NewActivityView(toDo: (previewThingsToDo.data[0]))
    }
}
