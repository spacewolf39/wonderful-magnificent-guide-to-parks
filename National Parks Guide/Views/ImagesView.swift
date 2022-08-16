//
//  ImagesView.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/17/22.
//

import Foundation
import SwiftUI
import CachedAsyncImage

func getImagesDestination(from park: Parks.dataResponse) -> AnyView {
//    let darkGreen = Color(red: 21/255, green: 71/255, blue: 52/255)
    
    return AnyView(
        
        ZStack{
            
            VStack {
                
                ScrollView {
                    
                    VStack {
                        let range = 0...(park.images.count - 1)
                        ForEach(range, id: \.self) { u in
                            
                            CachedAsyncImage(url: URL(string: "\(park.images[u].url)")) {
                                image in image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 350)
                                    .clipShape(Rectangle())
                                    .overlay {
                                        Rectangle().stroke(.white, lineWidth: 4)
                                    }
                                    .shadow(radius: 7)
                            } placeholder: {
                                ProgressView()
                            }
                            Text("\(park.images[u].title)").fontWeight(.bold).font(.title2)
                            Text("Credit: \(park.images[u].credit)")
                            Text("\(park.images[u].caption)")
                            
                        }
                        
                    }
                    Spacer()
                }
            }
        })
}
