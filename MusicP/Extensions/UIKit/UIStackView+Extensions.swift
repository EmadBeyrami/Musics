//
//  UIStackView+Extensions.swift
//  MusicP
//
//  Created by Emad Bayramy on 8/5/21.
//

import UIKit

extension UIStackView {
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach {
            self.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
}
