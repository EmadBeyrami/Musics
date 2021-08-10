//
//  BaseVC.swift
//  MusicP
//
//  Created by Emad Bayramy on 8/10/21.
//

import UIKit
import RxSwift

class BaseVC: UIViewController {
    
    // MARK: - Public Variables
    let disposeBag = DisposeBag()
    
    // MARK: - language callback handler
    var userChangedLanguageHandler: PublishSubject<SupportedLanguages> = PublishSubject()
    
    // MARK: - Language Action sheet
    lazy var changeLanguageAlertController: UIAlertController = {
        
        let alert = UIAlertController(title: LocalizedStrings.changeLanguage.value, message: nil, preferredStyle: .actionSheet)
        
        let englishLangAlert = UIAlertAction(title: SupportedLanguages.english.text, style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.userChangedLanguageHandler.onNext(.english)
        }
        
        let germanLangAlert = UIAlertAction(title: SupportedLanguages.german.text, style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.userChangedLanguageHandler.onNext(.german)
        }
        
        let cancelAction = UIAlertAction(title: LocalizedStrings.cancel.value, style: .cancel)
        
        alert.addAction(englishLangAlert)
        alert.addAction(germanLangAlert)
        alert.addAction(cancelAction)
        
        return alert
    }()
    
    // MARK: - public funcs
    // we can add action call back but in our case is unnessecary
    func showAlert(title: String = LocalizedStrings.error.value,
                   message: String = "",
                   actionBtnTitle: String = LocalizedStrings.ok.value) {
        let ac = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: actionBtnTitle, style: .default, handler: nil))
        self.present(ac, animated: true, completion: nil)
    }
}
