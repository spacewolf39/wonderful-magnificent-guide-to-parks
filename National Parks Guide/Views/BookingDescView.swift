//
//  BookingDescView.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/20/22.
//

import Foundation

import SwiftUI

func getBookingDesc(from toDo: ThingsToDo.dataResponse) -> AnyView {
    
    let reservationDescription = strip(string: toDo.reservationDescription)

    
    return AnyView(
        
        ZStack {
            
            if reservationDescription == "" {
                Text("No Reservations").fontWeight(.bold).font(.title).foregroundColor(Color.yellow).padding()
            } else {
        
            Text(reservationDescription).foregroundColor(Color.yellow).padding()
                
            }
            
        }
        
        )
}
