//
//  BottleCell.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 03.09.20.
//

import UIKit
import Nuke

final class BottleCell: UICollectionViewCell {
    static let reuseIdentifier = "BottleCell"
    
    private lazy var detailBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = UIColor.systemTeal.withAlphaComponent(0.6)
        view.layer.cornerRadius = 8
        
        return view
    }()
    
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
    
    func configure(article: Beverage.Article) {
        Nuke.loadImage(with: article.image, options: .beverageLoadingOptions, into: bottleImageView)
    }
}
