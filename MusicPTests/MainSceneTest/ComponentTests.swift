//
//  ComponentTests.swift
//  MusicPTests
//
//  Created by Emad Bayramy on 8/10/21.
//

import XCTest
@testable import MusicP

class ComponentTests: XCTestCase {

    func testBadgeView() throws {
        let badgeView = BadgeView()
        badgeView.setCount(22)
        
        var callBackResult: Int = 0
        badgeView.bind(completion: { (number) in
            callBackResult = number
        })
        
        badgeView.didTap(UITapGestureRecognizer())
        
        XCTAssertTrue(badgeView.badgeCountLabel.text == "22" && callBackResult == 22)
    }
}
