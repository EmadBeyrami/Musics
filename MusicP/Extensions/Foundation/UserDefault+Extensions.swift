//
//  UserDefault+Extensions.swift
//  MusicP
//
//  Created by Emad Bayramy on 8/10/21.
//

import Foundation

// Responsible for UserDefault of App
@propertyWrapper
struct UserDefault<T> {
    let key: UserDefaultsConfig.UserDefaultsKey
    let defaultValue: T

    init(_ key: UserDefaultsConfig.UserDefaultsKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key.rawValue) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}
