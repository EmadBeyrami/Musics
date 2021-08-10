//
//  CustomView.swift
//  MusicP
//
//  Created by Emad Bayramy on 8/5/21.
//

import UIKit

class CustomView: UIView {
    
    // MARK: Border
    @IBInspectable
    public var borderColors: UIColor = .black {
        didSet {
            layer.borderColor = borderColors.cgColor
        }
    }
    
    @IBInspectable
    public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    // MARK: corner Radius
    @IBInspectable
    public var cornerRadius: CGFloat = 15 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    // MARK: - top  corner Radius
    @IBInspectable
    public var topRoundCorners: CGFloat = 0 {
        didSet {
            roundCorners(corners: [.topLeft, .topRight], radius: topRoundCorners)
        }
    }
    
    // MARK: - bottom corner Radius
    @IBInspectable
    public var bottomRoundCorners: CGFloat = 0 {
        didSet {
            roundCorners(corners: [.bottomLeft, .bottomRight], radius: bottomRoundCorners)
        }
    }
    
   private func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            self.clipsToBounds = false
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
            let rectShape = CAShapeLayer()
            rectShape.bounds = self.frame
            rectShape.position = self.center
            rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
            self.layer.mask = rectShape
        }
    }
    
    ///
    @IBInspectable
    private var shadowColor: UIColor = .black {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable
    var addShadow: Bool = true {
        didSet {
            layer.shadowRadius = 5
            layer.shadowOffset = CGSize(width: 0, height: 0)
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOpacity = 0.1
            layer.cornerRadius = cornerRadius
        }
    }
    
    // MARK: Tap Gesture
    func addTapGesture(tapNumber: Int, target: Any, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layer.shadowColor = shadowColor.cgColor
        layer.borderColor = borderColors.cgColor
        if !gradientColors.isEmpty {
            applyGradient(colors: gradientColors, alpha: alpha)
        }
    }
    
    enum Direction: Int {
        case topToBottom
        case bottomToTop
        case leftToRight
        case rightToLeft
    }
    
    private var gradientColors: [UIColor] = []
    func applyGradient(colors: [UIColor], locations: [NSNumber]? = [0.0, 1.0], direction: Direction = .leftToRight, alpha: CGFloat) {
        self.alpha = alpha
        gradientColors = colors
        removeGradient()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors.compactMap({ $0.cgColor })
        gradientLayer.locations = locations
        
        switch direction {
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            
        case .bottomToTop:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
            
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            
        case .rightToLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        }
        
        self.layer.addSublayer(gradientLayer)
    }
    
    func removeGradient() {
        self.layer.sublayers = nil
        gradientColors = []
    }
}
