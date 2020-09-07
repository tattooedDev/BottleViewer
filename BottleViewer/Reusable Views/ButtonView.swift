//
//  ButtonView.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 04.09.20.
//

import UIKit

//MARK: - ButtonView Delegate
/// The delegate each view has to conform to when displaying the buttons
protocol ButtonViewDelegate: class {
    func buttonViewDidTapViewButton(_ buttonView: ButtonView)
    func buttonViewDidTapSortButton(_ buttonView: ButtonView)
    func buttonViewDidTapFilterButton(_ buttonView: ButtonView)
}

//MARK: - ButtonView
/// A custom view that displays three buttons in a vertical stack
final class ButtonView: UIView {
    
    /// The button that triggers a re-sort of the beverages
    private lazy var sortButton: UIButton = {
        let button = BeverageButton(title: "Sort")
        button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    /// The button that triggers the layout switching in the collection view
    private lazy var viewButton: UIButton = {
        let button = BeverageButton(title: "View")
        button.addTarget(self, action: #selector(viewButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    /// The button that triggers the filtering of the beverages
    private lazy var filterButton: UIButton = {
        let button = BeverageButton(title: "Filter")
        button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    /// A horizontal stack that holds all buttons
    private lazy var buttonStackView: UIStackView = {
        let stackView = BeverageStackView(axis: .horizontal, arrangedSubviews: [sortButton, viewButton, filterButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    weak var delegate: ButtonViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Private configuration method
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(buttonStackView)
        
        buttonStackView.pinToFourEdges(in: self)
    }
    
    //MARK: - ButtonViewDelegate methods
    @objc private func viewButtonTapped() {
        delegate?.buttonViewDidTapViewButton(self)
    }
    
    @objc private func sortButtonTapped() {
        delegate?.buttonViewDidTapSortButton(self)
    }
    
    @objc private func filterButtonTapped() {
        delegate?.buttonViewDidTapFilterButton(self)
    }
}
