//
//  BottleCollectionView.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 03.09.20.
//

import UIKit

final class BottleCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .systemBackground
        
        register(BottleCell.self, forCellWithReuseIdentifier: BottleCell.reuseIdentifier)
    }
}
