//
//  National_Parks_GuideApp.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/10/22.
//

import SwiftUI

;@main
struct National_Parks_GuideApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(parks: previewParks, park: previewParks.data[0])
        }
    }
}
