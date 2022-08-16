//
//  TestView.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/20/22.
//

import SwiftUI

struct TestView: View {
    @State private var isDisclosed = false
    
    var body: some View {
        VStack {
            Button("Expand") {
                withAnimation {
                    isDisclosed.toggle()
                }
            }
            .buttonStyle(.plain)
            
            
            VStack {
                GroupBox {
                    Text("Hi")
                }
                
                GroupBox {
                    Text("More details here")
                }
            }
            .frame(height: isDisclosed ? nil : 0, alignment: .top)
            .clipped()
            
            HStack {
                Text("Cancel")
                Spacer()
                Text("Book")
            }
        }
        .frame(maxWidth: .infinity)
        .background(.thinMaterial)
        .padding()
    }

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
}
