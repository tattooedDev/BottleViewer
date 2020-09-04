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
        contentView.addSubview(bottleImageView)
        
        bottleImageView.pinToFourEdges(in: contentView)
    }
    
    func configure(article: Beverage.Article) {
        Nuke.loadImage(with: article.image, options: .beverageLoadingOptions, into: bottleImageView)
    }
}
