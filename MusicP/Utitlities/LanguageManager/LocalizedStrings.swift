//
//  LocalizedStrings.swift
//  MusicP
//
//  Created by Emad Bayramy on 8/10/21.
//

import Foundation

// We can also using swiftgen for generating string files
enum LocalizedStrings: String {
    
    case discover, cancel, search, error, ok
    case changeLanguage = "Change_Lang"
    
    var value: String {
        return localized(key: self.rawValue)
    }
    
    private func localized(key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
