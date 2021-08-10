//
//  BaseModel.swift
//  MusicP
//
//  Created by Emad Bayramy on 8/5/21.
//

import Foundation

// MARK: - Base
struct Base: Codable {
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let sessions: [Session]?
}

// MARK: - Session
struct Session: Codable {
    let name: String?
    let listenerCount: Int?
    let genres: [String]?
    let currentTrack: CurrentTrack?

    enum CodingKeys: String, CodingKey {
        case name
        case listenerCount = "listener_count"
        case genres
        case currentTrack = "current_track"
    }
    
    func searchInGeneres(text: String) -> Bool {
        ((genres?.first(where: {$0.localizedCaseInsensitiveContains(text)})) != nil)
    }
}

// MARK: - CurrentTrack
struct CurrentTrack: Codable {
    let title: String?
    let artworkURL: String?

    enum CodingKeys: String, CodingKey {
        case title
        case artworkURL = "artwork_url"
    }
}
