//
//  BadgeView.swift
//  MusicP
//
//  Created by Emad Bayramy on 8/10/21.
//

import UIKit

class BadgeView: CustomView, ViewConnectable {
    
    // MARK: Type alias
    typealias BadgeViewTapHandlerType = DataCompletion<Int>
    
    // MARK: - IBOutlets
    @IBOutlet var badgeBackgroundView: CustomView!
    @IBOutlet var badgeImageView: UIImageView!
    @IBOutlet var badgeCountLabel: UILabel!
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        connectView()
        setupView()
    }
    
    // MARK: - View Setup
    private func setupView() {
        addTapGesture(tapNumber: 1,
                      target: self,
                      action: #selector(didTap(_:)))
    }
    
    @objc func didTap(_ tap: UITapGestureRecognizer) {
        let intNumber = Int(badgeCountLabel.text ?? "0")!
        didTapHandler(intNumber)
    }
    
    // MARK: - Public funcs (Setters and Getters)
    func setCount(_ number: Int) {
        let stringNumber = String(describing: number)
        badgeCountLabel.text = stringNumber
    }
    
    func setImage(image: UIImage? = nil, url: URL? = nil) {
        if let image = image {
            badgeImageView.image = image
            return
        }
        
        if let imageURL = url {
            badgeImageView.load(url: imageURL)
            return
        }
    }
    
    private var didTapHandler: BadgeViewTapHandlerType = { _ in }
    func bind(completion: @escaping BadgeViewTapHandlerType) {
        didTapHandler = completion
    }
}
