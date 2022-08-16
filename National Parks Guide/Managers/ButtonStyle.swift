//
//  ButtonStyle.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/28/22.
//

import Foundation
import SwiftUI

let softBlue = Color(red: 110/255, green: 136/255, blue: 152/255)

struct RoundedRectangleButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      Spacer()
      configuration.label.foregroundColor(Color.white)
      Spacer()
    }
    .padding()
    .background(softBlue.cornerRadius(8))
    .scaleEffect(configuration.isPressed ? 0.95 : 1)
  }
}
