//
//  StringReplace.swift
//  National Parks Guide
//
//  Created by Bryan Johnson on 7/19/22.
//

import Foundation

//function to strip html elements from a string

func strip(string: String) -> String {
    
    var string: String = string
    
    string = string.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    
    return string
}
