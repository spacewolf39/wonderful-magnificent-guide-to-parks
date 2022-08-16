//
//  PetFeesDescView.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/20/22.
//

import Foundation

import SwiftUI

func getPetDesc(from toDo: ThingsToDo.dataResponse) -> AnyView {
    
    let petsDescription = strip(string: toDo.petsDescription)

    
    return AnyView(
        
        ZStack {
            
            if petsDescription == "" {
                Text("No additional information about pets.")
            } else {
        
            Text(petsDescription).foregroundColor(Color.yellow).padding()
                
            }
            
        }
        
        )
}
