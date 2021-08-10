//
//  MusicService.swift
//  MusicP
//
//  Created by Emad Bayramy on 8/5/21.
//

import Foundation

/*

 This is Music Service, responsible for making api calls of getting Music List.
 
 */

typealias MusicListCompletionHandler = (Result<Base, RequestError>) -> Void

protocol MusicServiceProtocol {
    func getMusicList(completionHandler: @escaping MusicListCompletionHandler)
}

/*
 MusicEndPoints is URLPath of music Api calls
 */

private enum MusicEndPoints {
    case musicList
    
    var path: String {
        switch self {
        case .musicList:
            return "5df79b1f320000f4612e011e"
        }
    }
}

class MusicService: MusicServiceProtocol {
    
    private let requestManager: RequestManagerProtocol
    
    public static let shared: MusicServiceProtocol = MusicService(requestManager: RequestManager.shared)
    
    // We can also inject requestManager for testing purposes.
    init(requestManager: RequestManagerProtocol) {
        self.requestManager = requestManager
    }
    
    func getMusicList(completionHandler: @escaping MusicListCompletionHandler) {
        self.requestManager.performRequestWith(url: MusicEndPoints.musicList.path, httpMethod: .get) { (result: Result<Base, RequestError>) in
            // Taking Data to main thread so we can update UI.
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
    }
}
