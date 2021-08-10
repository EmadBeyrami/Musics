//
//  LabelBuilder.swift
//  MusicP
//
//  Created by Emad Bayramy on 7/23/21.
//

import Foundation
import UIKit

class LabelBuilder {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.minimumScaleFactor = 0.7
        return label
    }()
    
    // MARK: Builds Label
    func buildLabels(for strings: [String], color: UIColor = .white, seperator: String? = nil) -> [UILabel] {
        var labels: [UILabel] = []
        strings.forEach { str in
            label.text = str
            if seperator != nil { label.text?.append(seperator!) }
            label.textColor = color
            labels.append(label)
        }
        return labels
    }
    
    func buildLabel(for string: String, color: UIColor = .white) -> UILabel {
        label.text = string
        label.textColor = color
        return label
    }
    
}
