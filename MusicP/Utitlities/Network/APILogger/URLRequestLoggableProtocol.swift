//
//  URLRequestLoggableProtocol.swift
//  MusicP
//
//  Created by Emad Bayramy on 8/5/21.
//

import Foundation

protocol URLRequestLoggableProtocol {
    func logResponse(_ response: HTTPURLResponse?, data: Data?, error: Error?, HTTPMethod: String?)
}
