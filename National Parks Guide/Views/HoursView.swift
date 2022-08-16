//
//  HoursView.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/17/22.
//

import Foundation
import SwiftUI

func getHoursDestination(from park: Parks.dataResponse.operatingHoursResponse) -> AnyView {
    //    let darkGreen = Color(red: 21/255, green: 71/255, blue: 52/255)
    return AnyView(
        
        ZStack{
            GeometryReader { geo in
                VStack {
                    
                    ScrollView {
                        
                        Text("Standard Hours")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        //                    .foregroundColor(Color.yellow)
                        
                        VStack {
                            
                            Text("Monday: \(park.standardHours.monday)")
                            Text("Tuesday: \(park.standardHours.tuesday)")
                            Text("Wednesday: \(park.standardHours.wednesday)")
                            Text("Thursday: \(park.standardHours.thursday)")
                            Text("Friday: \(park.standardHours.friday)")
                            Text("Saturday: \(park.standardHours.saturday)")
                            Text("Sunday: \(park.standardHours.sunday)")
                            
                        }.lineSpacing(5).frame(width: geo.size.width)
                        
                        if park.exceptions != [] {
                            if park.exceptions?[0].exceptionHours != nil {
                                
                                VStack {
                                    
                                    Text("Exceptions")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                    //                    .foregroundColor(Color.yellow)
                                    
                                    VStack {
                                        
                                        //LOOPS THROUGH ALL EXCEPTIONS (NAME, DATES, DAYS and HOURS)
                                        
                                        ForEach(park.exceptions!) {p in
                                            
                                            VStack() {
                                                
                                                if p.startDate == p.endDate {
                                                    Text("\(p.name ?? "None") \(p.startDate ?? "None")").fontWeight(.bold).lineLimit(nil)
                                                } else {
                                                    Text("\(p.startDate ?? "None") through \(p.endDate ?? "None")")
                                                    
                                                }
                                                if p.exceptionHours.monday != nil {
                                                    Text("Monday: \(p.exceptionHours.monday ?? "None")")
                                                }
                                                if p.exceptionHours.tuesday != nil {
                                                    Text("Tuesday: \(p.exceptionHours.tuesday ?? "None")")
                                                }
                                                if p.exceptionHours.wednesday != nil {
                                                    Text("Wednesday: \(p.exceptionHours.wednesday ?? "None")")
                                                }
                                                if p.exceptionHours.thursday != nil {
                                                    Text("Thursday: \(p.exceptionHours.thursday ?? "None")")
                                                }
                                                if p.exceptionHours.friday != nil {
                                                    Text("Friday: \(p.exceptionHours.friday ?? "None")")
                                                }
                                                if p.exceptionHours.saturday != nil {
                                                    Text("Saturday: \(p.exceptionHours.saturday ?? "None")")
                                                }
                                                if p.exceptionHours.sunday != nil {
                                                    Text("Sunday: \(p.exceptionHours.sunday ?? "None")")
                                                }
                                            }
                                        }
                                    }.frame(width: geo.size.width)
                                }.lineSpacing(5)
                                
                            }
                            
                        }
                    }
                }
            }
            
        })
}
