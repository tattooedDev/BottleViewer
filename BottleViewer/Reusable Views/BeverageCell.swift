//
//  BeverageCell.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 03.09.20.
//

import UIKit

protocol BeverageCellDelegate: UIViewController {
    func beverageCell(_ beverageCell: BeverageCell, didFailWithError error: Error)
}

final class BeverageCell: UITableViewCell {
    static let reuseIdentifier = "BeverageCell"
    
    private lazy var beverageImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "photo")!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var beverageNameLabel: UILabel = {
        let label = BeverageDetailLabel()
        
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = BeverageDetailLabel()
        
        return label
    }()
    
    private lazy var pricePerUnitLabel: UILabel = {
        let label = BeverageDetailLabel()
        
        return label
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stackView = BeverageStackView(axis: .vertical, arrangedSubviews: [beverageNameLabel, priceLabel, pricePerUnitLabel])
        
        return stackView
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let stackView = BeverageStackView(axis: .horizontal, arrangedSubviews: [beverageImageView, verticalStack])
        
        return stackView
    }()
    
    weak var delegate: BeverageCellDelegate?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        beverageImageView.image = nil
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(horizontalStack)
        
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with beverage: Beverage) {
        Networker.shared.request(URLRequestFactory.imageURLRequest(for: beverage)) { [weak self] result in
            guard let self = self else { return }
            
            do {
                let data = try result.get()
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.beverageImageView.image = image
                }
            } catch {
                self.delegate?.beverageCell(self, didFailWithError: error)
            }
        }
        
        beverageNameLabel.text = beverage.brandName
        priceLabel.text = beverage.articles.first?.formattedPrice
        pricePerUnitLabel.text = beverage.articles.first?.shortDescription
    }
}
