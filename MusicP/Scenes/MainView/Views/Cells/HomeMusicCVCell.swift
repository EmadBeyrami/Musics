//
//  HomeMusicCVCell.swift
//  MusicP
//
//  Created by Emad Bayramy on 7/23/21.
//

import Foundation
import UIKit

class HomeMusicCVCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    // Not using weak IBOultet because: https://stackoverflow.com/a/31395938
    @IBOutlet var bgImageView: UIImageView!
    @IBOutlet var gradientView: CustomView!
    @IBOutlet var badgeView: BadgeView!
    @IBOutlet var songDetailStackView: UIStackView!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var genresLabel: UILabel!
    
    // MARK: - Properties
    private var genres = [String]()
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bgImageView.image = nil
        badgeView.setCount(0)
        genresLabel.text = ""
        nameLbl.text = ""
        gradientView.removeGradient()
        genres = []
    }
    
    // MARK: - View Setup
    private func setupView() {
        let color: UIColor = .black
        gradientView.applyGradient(colors: [color, .clear.withAlphaComponent(0.0)], locations: [0.0, 1.0], alpha: 0.6)
        gradientView.clipsToBounds = true
    }
    
    private func setupGenres() {
        
        guard !genres.isEmpty else {
            genresLabel.text = "No Genre"
            return
        }
        
        genresLabel.text = ""
        genres.forEach({ genresLabel.text? += ", " + $0})
        genresLabel.text = String(describing: genresLabel.text!.dropFirst(2))
        
    }
    
    // MARK: - Cell filler
    private func fillCell(with data: Session) {
        defer {
            setupGenres()
        }
        
        gradientView.removeGradient()
        setupView()
        if let artwork = data.currentTrack?.artworkURL,
           let artworkUrl = URL(string: artwork) {
            bgImageView.load(url: artworkUrl)
        }
        badgeView.setCount(data.listenerCount ?? 0)
        nameLbl.text = data.currentTrack?.title ?? "-"
        
        data.genres?.forEach({ genre in
            genres.append(genre)
        })
        
    }
    
}

// MARK: - CollectionView Cell
extension HomeMusicCVCell: MusicCollectionViewCell {
    typealias CellViewModel = Session
    
    func configCellSize(item: Session) -> CGSize {
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidthAndHeight = (deviceWidth - 30) / 2
        return CGSize(width: cellWidthAndHeight, height: cellWidthAndHeight)
    }
    
    func configureCellWith(_ item: Session) {
        fillCell(with: item)
    }
}
