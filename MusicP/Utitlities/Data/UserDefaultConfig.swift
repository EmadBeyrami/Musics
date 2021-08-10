//
//  UserDefaultConfig.swift
//  MusicP
//
//  Created by Emad Bayramy on 8/10/21.
//

import Foundation

struct UserDefaultsConfig {
    
    enum UserDefaultsKey: String {
        case appleLanguages  = "AppleLanguages"
        case currentLanguage
    }
    
    @UserDefault(.currentLanguage, defaultValue: "en")
    static var currentLanguage: String
    
    @UserDefault(.appleLanguages, defaultValue: ["en"])
    static var appleLanguage: [String]
    
    static func clearUserDefaultFor(_ key: UserDefaultsKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func clearAllUserDefault() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
        UserDefaults.standard.synchronize()
    }
}
