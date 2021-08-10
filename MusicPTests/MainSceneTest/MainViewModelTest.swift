//
//  MainViewModelTest.swift
//  MusicPTests
//
//  Created by Emad Bayramy on 8/10/21.
//

import XCTest
import RxSwift
@testable import MusicP

class MainViewModelTest: XCTestCase {
    
    var sut: MainViewModel?
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
    
    func testSearch() throws {
        let urlSessionMock = URLSessionMock()
        urlSessionMock.data = musicListJSON
        let mockRequestManager = RequestManagerMock(session: urlSessionMock, validator: MockResponseValidator())
        let musicService = MusicService(requestManager: mockRequestManager)
        sut = MainViewModel(musicService: musicService)
        
        sut?.getMusicList()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let res1 = self.sut?.search(for: "W") // expect 3
            let res2 = self.sut?.search(for: "jazz") // expect 2
            let res3 = self.sut?.search(for: "tumbao") // expect 1
            
            let condition1 = (res1?.count == 3)
            let condotion2 = (res2?.count == 2)
            let condotion3 = (res3?.count == 1)
            XCTAssertTrue(condition1 && condotion2 && condotion3)
        }
        
    }
}
