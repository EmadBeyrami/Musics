//
//  LanguageManager.swift
//  MusicP
//
//  Created by Emad Bayramy on 8/10/21.
//

import Foundation
import UIKit

enum SupportedLanguages: Int, CaseIterable {
    case english
    case german
    
    var languageDirection: LanguageDirection {
        switch self {
        case .english:
            return .ltr
        case .german:
            return .ltr
        }
    }
}

@objc enum LanguageDirection: Int {
    case rtl
    case ltr
}

protocol LanguageManagerProtocol {
    var currentLanguage: SupportedLanguages { get set }
    var allSupportedLanguages: [SupportedLanguages] { get }
}

class LanguageManager: LanguageManagerProtocol {
    // MARK: - Properties
    static let shared: LanguageManager = LanguageManager()
    
    var allSupportedLanguages: [SupportedLanguages] = SupportedLanguages.allCases
    var currentLanguage: SupportedLanguages {
        get {
            let identifier = UserDefaultsConfig.currentLanguage
            return SupportedLanguages(identifier: identifier)
        }
        set {
            UserDefaultsConfig.currentLanguage = newValue.identifier
            UIView.appearance().semanticContentAttribute = newValue.direction.semantic
            Bundle.setLanguage(newValue.identifier)
        }
    }
    
    var languagecalendar: Calendar {
        let locale = Locale(identifier: currentLanguage.locale)
        return locale.calendar
    }
    // MARK: - Methods
    private init() {}
    
    class func isAValidLanguageIdentifier(_ identifier: String) -> Bool {
        for language in shared.allSupportedLanguages where language.identifier == identifier {
            return true
        }
        return false
    }
}

extension SupportedLanguages {
    var text: String {
        switch self {
        case .english:
            return "English"
        case .german:
            return "Deutsch"
        }
    }
    
    var identifier: String {
        switch self {
        case .english:
            return "en-US"
        case .german:
            return "de"
        }
    }
    
    var direction: LanguageDirection {
        switch self {
        case .english:
            return .ltr
        case .german:
            return .ltr
        }
    }
    
    var textAlignment: NSTextAlignment {
        switch self {
        case .english:
            return .left
        case .german:
            return .left
        }
    }
    
    var oppositeTextAlignment: NSTextAlignment {
        switch self {
        case .english:
            return .left
        case .german:
            return .left
        }
    }
    
    var locale: String {
        switch self {
        case .english:
            return "en"
        case .german:
            return "de"
        }
    }
    
    init(identifier: String?) {
        switch identifier ?? "en-US" {
        case "en-US":
            self = .english
        case "de":
            self = .german
        default:
            self = .english
        }
    }
}

extension LanguageDirection {
    var semantic: UISemanticContentAttribute {
        switch self {
        case .ltr:
            return .forceLeftToRight
        case .rtl:
            return .forceRightToLeft
        }
    }
}
