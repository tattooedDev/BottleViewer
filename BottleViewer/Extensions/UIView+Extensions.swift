//
//  UIView+Extensions.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 03.09.20.
//

import UIKit

extension UIView {
    /// Helper method to pin the view to the four edges of its superview
    /// - Parameter view: The superview
    func pinToFourEdges(in view: UIView) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    /// A helper method that extends `addSubview`
    /// - Parameter views: The views to add
    func addSubViews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
