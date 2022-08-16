//
//  ActivityFeesView.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/20/22.
//

import Foundation

import SwiftUI

func getActivityFees(from toDo: ThingsToDo.dataResponse) -> AnyView {
    
    let feeDescription = strip(string: toDo.feeDescription)

    
    return AnyView(
        
        ZStack {
            
            if feeDescription == "" {
                Text("No Fees for this Activity")
            } else {
        
            Text(feeDescription).padding()
            
            }
            
        }
        
        )
}
