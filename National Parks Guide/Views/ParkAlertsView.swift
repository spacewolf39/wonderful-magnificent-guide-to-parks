//
//  ParkAlertsView.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/29/22.
//

import SwiftUI

struct ParkAlertsView: View {
    
    var alerts: Alerts
    
    var park: Parks.dataResponse
    
    var body: some View {
        
        if alerts.data != [] {
        
        List {
            
            ForEach(alerts.data, id: \.self) {alert in
                NavigationLink(alert.title, destination: AlertDetailView(alert: alert, park: park))
            }
        }
        } else {
            Text("No Alerts Found")
        }
    }
}

struct ParkAlertsView_Previews: PreviewProvider {
    static var previews: some View {
        ParkAlertsView(alerts: previewAlerts, park: previewParks.data[0])
    }
}
