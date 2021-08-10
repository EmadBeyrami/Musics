//
//  ReactiveX+Extensions.swift
//  MusicP
//
//  Created by Emad Bayramy on 8/6/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIView {
    
    /// Bindable sink for `animateActivityIndicator()`, `removeActivityIndicator()` methods.
    public var isAnimating: Binder<Bool> {
        return Binder(base, scheduler: MainScheduler.instance, binding: { (view, active) in
            if active {
                view.animateActivityIndicator()
            } else {
                view.removeActivityIndicator()
            }
        })
    }
}
