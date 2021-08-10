//
//  ServicesTest.swift
//  MusicPTests
//
//  Created by Emad Bayramy on 8/10/21.
//

import XCTest
@testable import MusicP

final class PlaceServiceTests: XCTestCase {
    
    var sut: MusicService?
    var musicListJSON: Data?
    
    override func setUp() {
        let bundle = Bundle(for: type(of: self))
        if let path = bundle.path(forResource: "MusicListMock", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                self.musicListJSON = data
            } catch {
                
            }
        }
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_getMusicList() {
        
        // Given
        let urlSessionMock = URLSessionMock()
        urlSessionMock.data = musicListJSON
        let mockRequestManager = RequestManagerMock(session: urlSessionMock, validator: MockResponseValidator())
        sut = MusicService(requestManager: mockRequestManager)
        let expectation = XCTestExpectation(description: "Async query test")
        var baseResponse: Base?
        
        // When
        sut?.getMusicList(completionHandler: { (result) in
            defer {
                expectation.fulfill()
            }
            switch result {
            case .success(let response):
                baseResponse = response
            case .failure:
                XCTFail("Failed to get Result")
            }
        })
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertTrue(baseResponse?.data?.sessions?.count == 10)
    }
}
