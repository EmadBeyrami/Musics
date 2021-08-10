//
//  MusicCollectionViewCell.swift
//  MusicP
//
//  Created by Emad Bayramy on 8/5/21.
//

import UIKit

protocol MusicCollectionViewCell: UICollectionViewCell {
    associatedtype CellViewModel
    func configureCellWith(_ item: CellViewModel)
    func configCellSize(item: CellViewModel) -> CGSize
}
