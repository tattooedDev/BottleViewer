//
//  ButtonView.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 04.09.20.
//

import UIKit

protocol ButtonViewDelegate: class {
    func buttonViewDidTapViewButton(_ buttonView: ButtonView)
    func buttonViewDidTapSortButton(_ buttonView: ButtonView)
    func buttonViewDidTapFilterButton(_ buttonView: ButtonView)
}

final class ButtonView: UIView {
    
    private lazy var sortButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sort", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var viewButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("View", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self, action: #selector(viewButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Filter", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
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
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(buttonStackView)
        
        buttonStackView.pinToFourEdges(in: self)
    }
    
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
