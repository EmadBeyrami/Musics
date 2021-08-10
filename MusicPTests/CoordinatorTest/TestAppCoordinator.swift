//
//  TestAppCoordinator.swift
//  MusicPTests
//
//  Created by Emad Bayramy on 8/10/21.
//

import XCTest
@testable import MusicP

class TestAppCoordinator: XCTestCase {

    var sut: AppCoordinator?
    var window: UIWindow?
    
    override func tearDownWithError() throws {
        sut = nil
        window = nil
        try? super.tearDownWithError()
    }
    
    override func setUp() {
        let nav = UINavigationController()
        window = UIWindow(frame: UIScreen.main.bounds)
        sut = AppCoordinator(navigationController: nav, window: window)
    }
    
    override func tearDown() {
        sut = nil
        window = nil
    }
    
    func test_start() throws {
        // given
        guard let sut = sut else {
            throw UnitTestError()
        }
        
        // when
        sut.start(animated: false)
        
        // then
        XCTAssertEqual(sut.navigationController.viewControllers.count, 1)
        let rootVC = sut.navigationController.viewControllers[0] as? MainViewController
        XCTAssertNotNil(rootVC, "Check if root vsc is FlowControlViewController")
    }
    
    func test_ChildDidFinish() throws {
        // given
        guard let sut = sut else {
            throw UnitTestError()
        }
        // when
        let child = AppCoordinator(navigationController: sut.navigationController, window: window)
        sut.childCoordinators.append(child)
        sut.childDidFinish(child)
        
        // then
        XCTAssertTrue(sut.childCoordinators.count == 0)
    }

}
