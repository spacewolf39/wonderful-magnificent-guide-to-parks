//
//  NewDestinationView.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/25/22.
//

import SwiftUI
import MapKit
import CachedAsyncImage

struct NewDestinationView: View {

    var park: Parks.dataResponse

    let darkGreen = Color(red: 21/255, green: 71/255, blue: 52/255)
    let softBlue = Color(red: 110/255, green: 136/255, blue: 152/255)
    let activityLogo = Image(systemName: "figure.walk")
    let hoursLogo = Image(systemName: "clock")
    let photosLogo = Image(systemName: "camera")
    
    let weatherManager = WeatherManager()
    
    @State var weather: Weather?
    
    @State var latitude: Double = 0.0
    @State var longitude: Double = 0.0
    @State var region = MKCoordinateRegion()
    @State var parkCode: String

    var body: some View {
        
        var latitude = Double(park.latitude) ?? 0
        var longitude = Double(park.longitude) ?? 0
        let places = [PointOfInterest(name: "\(park.fullName)", latitude: latitude, longitude: longitude)]
        
        ZStack {

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

                            Text(park.fullName).fontWeight(.bold).font(.title).foregroundColor(Color.white).offset(y: 50)

                        }

                        ZStack {

                            Rectangle().fill(Color(red: 110/255, green: 136/255, blue: 152/255)).frame(width: geo.size.width, height: 60).offset(y: 20) //rectangle for buttons

                            HStack {

                                Spacer()

                                // button for things to do / activities

                                Button(action: {
                                }) {

                                    NavigationLink(destination: NewThingsToDoView(park: park, parkCode: park.parkCode)) {

                                        VStack (spacing: 4) {

                                            Text(activityLogo).padding().background(Color(red: 21/255, green: 71/255, blue: 52/255))
                                                .clipShape(Circle())
                                                .foregroundColor(Color.white)
                                                .shadow(radius: 7)

                                            Text("Activities").foregroundColor(Color.white)

                                        }

                                    }

                                }

                                Spacer()

                                Button(action: {
                                }) {

                                    if park.operatingHours != [] {
                                        NavigationLink(destination: getHoursDestination(from:park.operatingHours[0])) {

                                            VStack (spacing: 4) {

                                                Text(hoursLogo).padding().background(Color(red: 21/255, green: 71/255, blue: 52/255))
                                                    .clipShape(Circle())
                                                    .foregroundColor(Color.white)
                                                    .shadow(radius: 7)

                                                Text("Hours").foregroundColor(Color.white)

                                            }

                                        }
                                    } else {

                                        VStack (spacing: 4) {

                                            Text(Image(systemName: "nosign")).padding().background(Color(red: 21/255, green: 71/255, blue: 52/255))
                                                .clipShape(Circle())
                                                .foregroundColor(Color.white)
                                                .shadow(radius: 7)

                                            Text("Hours").foregroundColor(Color.white)

                                        }

                                    }


                                }

                                Spacer()

                                Button(action: {
                                }) {

                                    NavigationLink(destination: getImagesDestination(from:park)) {

                                        VStack (spacing: 4) {

                                            Text(photosLogo).padding().background(Color(red: 21/255, green: 71/255, blue: 52/255))
                                                .clipShape(Circle())
                                                .foregroundColor(Color.white)
                                                .shadow(radius: 7)

                                            Text("Photos").foregroundColor(Color.white)

                                        }

                                    }

                                }

                                Spacer()

                                Button(action: {

                                    let latitude = park.latitude
                                    let longitude = park.longitude
                                    let url = URL(string: "maps://?saddr=&daddr=\(latitude),\(longitude)")

                                    if UIApplication.shared.canOpenURL(url!) {
                                        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                                    }

                                }) {

                                    VStack (spacing: 4) {

                                        Text(Image(systemName: "arrow.triangle.branch")).padding().background(Color(red: 21/255, green: 71/255, blue: 52/255))
                                            .clipShape(Circle())
                                            .foregroundColor(Color.white)
                                            .shadow(radius: 7)

                                        Text("Directions").foregroundColor(Color.white)

                                    }

                                }

                                Spacer()

                            }.offset(y: 2)

                        }.offset(y: -50) //ZStack Buttons and Rectangle
                        
                        //About

                        VStack (spacing: 5) {

                        Text("About:").fontWeight(.bold).frame(width: geo.size.width * 0.95, alignment: .leading)

                        Text(park.description).lineLimit(nil)

                        }.frame(width: geo.size.width * 0.95).offset(y: -20).lineSpacing(5)
                        
                        HStack (spacing: 10) {
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 10).fill(softBlue)
                            
                            NavigationLink(destination: EventsAPICall(park: park, parkCode: $parkCode)) {
                                Text("Events").foregroundColor(Color.white).fontWeight(.bold)
                            }
                        }
                        .onAppear(){
                            parkCode = park.parkCode
                        }.buttonStyle(RoundedRectangleButtonStyle()).frame(width: geo.size.width * 0.45)
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 10).fill(softBlue)
                            
                            NavigationLink(destination: AlertsAPICall(park: park, parkCode: $parkCode)) {
                                Text("Alerts").foregroundColor(Color.white).fontWeight(.bold)
                            }
                        }
                        .onAppear(){
                            parkCode = park.parkCode
                        }.buttonStyle(RoundedRectangleButtonStyle()).frame(width: geo.size.width * 0.45)
                            
                        }.offset(y: -15)
                        
                        
                        
                        //Map of single park

                        Map(coordinateRegion: $region, annotationItems: places) { place in
                            MapMarker(coordinate: place.coordinate)}
                        .onAppear {
                                        latitude = (Double(park.latitude) ?? 0.0)
                                        longitude = (Double(park.longitude) ?? 0.0)
                                        region = MKCoordinateRegion(
                                            center: CLLocationCoordinate2D(latitude: latitude , longitude: longitude),
                                            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                        }
                        .frame(width: geo.size.width * 0.95, height: 300)
                        .clipShape(Rectangle())
                        .overlay {
                            Rectangle().stroke(.white, lineWidth: 4)
                        }
                        .shadow(radius: 7)
                        
                        // Directions Info

                        VStack (spacing: 5) {

                            if park.directionsInfo != "" {

                        Text("Getting There:").fontWeight(.bold).frame(width: geo.size.width * 0.95, alignment: .leading)

                        Text(park.directionsInfo).lineLimit(nil)

                            }

                        }.frame(width: geo.size.width * 0.95).lineSpacing(5).offset(y: 20)

                        Rectangle()
                            .frame(width: geo.size.width * 0.95, height: 2)
                            .foregroundColor(Color.yellow).offset(y: 20)

//                        WEATHER VIEW

                        if let weather = weather {
                            WeatherView(weather: weather).frame(width: geo.size.width * 0.95, height: 100)
                        } else {
                            ProgressView("Fetching Weather")
                                .task {
                                    do {
                                        weather = try await weatherManager.getCurrentWeather(latitude: latitude, longitude: longitude)
                                    } catch {
                                        print("Error getting weather: \(error)")
                                    }

                                }
                        }

                        // Entrance Fees

                        VStack (spacing: 5) {

                            if park.entranceFees != [] {

                        Text("Entrance Fees:").fontWeight(.bold).frame(width: geo.size.width * 0.95, alignment: .leading)

                            ForEach(park.entranceFees) { cost in

                                if cost.cost == "0.00" {
                                    Text("No Entrance Fees")
                                } else {

                                Text(cost.title)

                                Text(cost.description)

                                Text("$\(cost.cost)")

                                }

                                }

                            } else {

                                Text("No Entrance Fees")

                            }

                        }.frame(width: geo.size.width * 0.95).lineSpacing(5).offset(y: 30).lineLimit(nil)

                    }

                }.frame(width: geo.size.width).edgesIgnoringSafeArea(.top)
            
            }
        }

    }
}

struct NewDestinationView_Previews: PreviewProvider {
    static var previews: some View {
        NewDestinationView(park: previewParks.data[0], weather: previewWeather, parkCode: "acad")
    }
}
