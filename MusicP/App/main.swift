//
//  main.swift
//  MusicP
//
//  Created by Emad Bayramy on 8/10/21.
//

import UIKit

// If the user's Language is RTL we set all views Layout directions
class Application: UIApplication, UIApplicationDelegate {
    override var userInterfaceLayoutDirection: UIUserInterfaceLayoutDirection {
        return LanguageManager.shared.currentLanguage.direction == .ltr ? .leftToRight : .rightToLeft
    }
}

/// This function avoids calls for AppDelegate in UnitTest.
private func delegateClassName() -> String? {
    return NSClassFromString("XCTestCase") == nil ? NSStringFromClass(AppDelegate.self) : nil
}

var currentLanguage = UserDefaultsConfig.currentLanguage
if !LanguageManager.isAValidLanguageIdentifier(currentLanguage) {
    currentLanguage = SupportedLanguages.english.identifier
}

UserDefaultsConfig.appleLanguage = [SupportedLanguages.english.identifier]
LanguageManager.shared.currentLanguage = SupportedLanguages(identifier: currentLanguage)

let argc = CommandLine.argc
let argv = CommandLine.unsafeArgv
  _ = UIApplicationMain(argc, argv, NSStringFromClass(Application.self), delegateClassName())
