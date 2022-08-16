//
//  WeatherView.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/25/22.
//

import SwiftUI

struct WeatherView: View {
    
    var weather: Weather
    
    var body: some View {
        
        GeometryReader { geo in
            
            VStack (spacing: 10) {
        
        Text("Current Weather:").fontWeight(.bold).frame(width: geo.size.width * 0.95, alignment: .leading).offset(y: 20)
        
        HStack (spacing: 40) {
                
                VStack {
                    
                    if weather.main.temp >= 70.0 {
                    
            Image(systemName: "sun.min")
                        
                    } else if weather.main.temp > 90 {
                    
            Image(systemName: "sun.max")
                    
                    } else if weather.main.temp < 50 {
                    
                    Image(systemName: "snowflake.circle")
                    
                    } else if weather.main.temp < 70 {
                    
                    Image(systemName: "cloud")
                    
                    }
                    
            Text("\(weather.main.temp.roundDouble() + "º")")
                    
            Text("Temp")
                    
                
                    
                }
                
                VStack {
                    
            Image(systemName: "thermometer.snowflake")
            
            Text("\(weather.main.temp_min.roundDouble() + "º")")
                    
            Text("Low")
                    
                }
                
                VStack {
                    
            Image(systemName: "thermometer.sun")
            
            Text("\(weather.main.temp_max.roundDouble() + "º")")
                    
            Text("High")
                    
                }
                    
                    VStack (spacing: 3) {
                        
                Image(systemName: "wind")
                        
                        HStack {
                        
                Text("\(weather.wind.speed.roundDouble())")
                Text("m/s")
                            
                        }
                        
                Text("Wind")
                  
                
            }
            
            
        }.offset(y: 25)
            
        }
            
        }
        
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
