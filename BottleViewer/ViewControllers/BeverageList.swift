//
//  BeverageList.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 03.09.20.
//

import UIKit

final class BeverageList: UIViewController {
    enum Selection {
        case tableView, collectionView
    }
    
    private lazy var beerListViewController: UIViewController = {
        let beerListViewController = BeerListViewController()
        
        return beerListViewController
    }()
    
    private lazy var beerCollectionViewController: UIViewController = {
        let beerCollectionViewController = BeerCollectionViewController()
        
        return beerCollectionViewController
    }()
    
    private lazy var sortButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sort", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self, action: #selector(sortBeverages), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var viewButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("View", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self, action: #selector(switchView), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Filter", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self, action: #selector(filterBeverages), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stackView = BeverageStackView(axis: .horizontal, arrangedSubviews: [sortButton, viewButton, filterButton])
        
        return stackView
    }()
    
    private var selection = Selection.tableView
    private let store = BeverageStore.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        title = "Beers"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .systemBackground
        
        navigationItem.titleView = verticalStack
        
        add(beerListViewController)
    }
    
    @objc func sortBeverages() {
        store.sortBeverages()
    }
    
    @objc private func filterBeverages() {
        store.filterBeverages()
    }
    
    @objc private func switchView() {
        switch selection {
            case .tableView:
                selection = .collectionView
                beerCollectionViewController.remove()
                add(beerListViewController)
            case .collectionView:
                selection = .tableView
                beerListViewController.remove()
                add(beerCollectionViewController)
        }
    }
}
