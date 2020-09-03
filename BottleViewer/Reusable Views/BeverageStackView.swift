//
//  BeverageStackView.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 03.09.20.
//

import UIKit

final class BeverageStackView: UIStackView {
    
    init(axis: NSLayoutConstraint.Axis, arrangedSubviews: [UIView]) {
        super.init(frame: .zero)
        
        self.axis = axis
        
        arrangedSubviews.forEach { self.addArrangedSubview($0) }
        
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        distribution = .fillEqually
    }
}
