//
//  DetailCell.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 04.09.20.
//

import UIKit
import Nuke

/// Detail Cell which displays a bottle and some details about the article
final class DetailCell: UICollectionViewCell {
    //MARK: - Reuse Identifier
    static let reuseIdentifier = "DetailCell"
    
    /// Custom background view for simplified styling
    private lazy var detailBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = UIColor.customBackgroundColor.withAlphaComponent(0.6)
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    /// The image view that displays the individual bottle
    private lazy var bottleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    /// The label that displays the name of the article
    private lazy var nameLabel: UILabel = {
        let label = BeverageDetailLabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    /// The label that displays the price of the article
    private lazy var priceLabel: UILabel = {
        let label = BeverageDetailLabel()
        
        return label
    }()
    
    /// The label that displays the description of the article, in this case the short description (price/Liter)
    private lazy var descriptionLabel: UILabel = {
        let label = BeverageDetailLabel()
        
        return label
    }()
    
    /// A vertical stack view that displays the labels
    private lazy var labelStackView: UIStackView = {
        let stackView = BeverageStackView(axis: .vertical, arrangedSubviews: [nameLabel, priceLabel, descriptionLabel])
        
        return stackView
    }()
    
    /// A horizontal stack view that displays the bottleImageView alongside the labelStackView
    private lazy var stackView: UIStackView = {
        let stackView = BeverageStackView(axis: .horizontal, arrangedSubviews: [bottleImageView, labelStackView])
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        bottleImageView.image = nil
    }
    
    /// Configuration method for setting up the cell with Auto Layout setup
    private func configure() {
        contentView.addSubview(detailBackgroundView)
        detailBackgroundView.addSubview(stackView)
        
        bottleImageView.widthAnchor.constraint(equalToConstant: 71.5).isActive = true
        
        detailBackgroundView.pinToFourEdges(in: contentView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: detailBackgroundView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: detailBackgroundView.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: detailBackgroundView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: detailBackgroundView.trailingAnchor, constant: -20)
        ])
    }
    
    /// Public configuration method which gets called by collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    /// - Parameters:
    ///   - name: The name of the article
    ///   - article: The article to display
    func configure(withName name: String, article: Beverage.Article) {
        Nuke.loadImage(with: article.image, options: .beverageLoadingOptions, into: bottleImageView)
        
        nameLabel.text = name
        priceLabel.text = article.formattedPrice
        descriptionLabel.text = article.shortDescription
    }
}
