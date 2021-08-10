//
//  ResponseValidatorProtocol.swift
//  MusicP
//
//  Created by Emad Bayramy on 8/5/21.
//

import Foundation

protocol ResponseValidatorProtocol {
    func validation<T: Codable>(response: HTTPURLResponse?, data: Data?) -> Result<T, RequestError>
}
