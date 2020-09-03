//
//  BeverageCell.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 03.09.20.
//

import UIKit

final class BeverageCell: UITableViewCell {
    static let reuseIdentifier = "BeverageCell"
    
    private lazy var beverageImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "photo")!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var beverageNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var pricePerUnitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [beverageNameLabel, priceLabel, pricePerUnitLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [beverageImageView, verticalStack])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        return stackView
    }()

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
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with beverage: Beverage) {
        Networker.shared.request(URLRequestFactory.imageURLRequest(for: beverage)) { result in
            do {
                let data = try result.get()
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.beverageImageView.image = image
                    self.layoutIfNeeded()
                }
            } catch {
                print(error)
            }
        }
        
        beverageNameLabel.text = beverage.brandName
        priceLabel.text = beverage.articles.first?.formattedPrice
        pricePerUnitLabel.text = beverage.articles.first?.shortDescription
    }
}
