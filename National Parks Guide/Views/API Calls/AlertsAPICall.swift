//
//  AlertsAPICall.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/29/22.
//

import SwiftUI

struct AlertsAPICall: View {
    
    var parkAlertsModel = ParkAlertsModel()
    
    @State var alerts: Alerts?
    
    var park: Parks.dataResponse
    
    @Binding var parkCode: String
    
    var body: some View {
        if let alerts = alerts {
            
            ParkAlertsView(alerts: alerts, park: park)
            
        } else {
            
             ProgressView("Finding Alerts")
                .task {
                    do {
                        alerts = try await parkAlertsModel.getAlerts(parkCode: parkCode)
                    } catch {
                        print("Error getting alerts: \(error)")
                    }
                }
        }
    }
}

struct AlertsAPICall_Previews: PreviewProvider {
    static var previews: some View {
        AlertsAPICall(park: previewParks.data[0], parkCode: .constant("acad"))
    }
}
