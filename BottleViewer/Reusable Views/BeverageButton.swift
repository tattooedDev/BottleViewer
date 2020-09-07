//
//  BeverageButton.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 07.09.20.
//

import UIKit

/// Reusable and pre-configured button
final class BeverageButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(.customBackgroundColor, for: .normal)
        setTitleColor(UIColor.customBackgroundColor.withAlphaComponent(0.5), for: .highlighted)
    }
}
