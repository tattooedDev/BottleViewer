//
//  BottleCell.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 03.09.20.
//

import UIKit
import Nuke

/// Reusable cell for displaying bottles
final class BottleCell: UICollectionViewCell {
    //MARK: - Reuse Identifier
    static let reuseIdentifier = "BottleCell"
    
    /// Custom background view for simplified styling
    private lazy var detailBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = UIColor.customBackgroundColor.withAlphaComponent(0.6)
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    /// The image view that displays the individial bottle
    private lazy var bottleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Cell configuration with Auto Layout setup
    private func configure() {
        contentView.addSubview(detailBackgroundView)
        detailBackgroundView.addSubview(bottleImageView)
        
        detailBackgroundView.pinToFourEdges(in: contentView)
        
        NSLayoutConstraint.activate([
            bottleImageView.topAnchor.constraint(equalTo: detailBackgroundView.topAnchor, constant: 5),
            bottleImageView.bottomAnchor.constraint(equalTo: detailBackgroundView.bottomAnchor, constant: -5),
            bottleImageView.leadingAnchor.constraint(equalTo: detailBackgroundView.leadingAnchor, constant: 5),
            bottleImageView.trailingAnchor.constraint(equalTo: detailBackgroundView.trailingAnchor, constant: -5)
        ])
    }
    
    /// Public configuration method which gets called by collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    /// - Parameter article: The article to display
    func configure(article: Beverage.Article) {
        Nuke.loadImage(with: article.image, options: .beverageLoadingOptions, into: bottleImageView)
    }
}
