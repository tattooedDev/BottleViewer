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
    
    private lazy var tableView: BeveragesTableView = {
        let tableView = BeveragesTableView(frame: .zero, style: .insetGrouped)
        
        tableView.dataSource = self
        
        return tableView
    }()
    
    private lazy var collectionView: BottleCollectionView = {
        let collectionView = BottleCollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    private lazy var collectionViewLayout: UICollectionViewLayout = {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    private let store = BeverageStore()
    private var beverages = [Beverage]()
    private var imageURLs = [URL]()
    private var selection = Selection.tableView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        title = "Beers"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(switchView))
        
        view.backgroundColor = .systemBackground
        
        switch selection {
            case .tableView:
                view.addSubview(tableView)
                
                tableView.pinToFourEdges(in: view)
                
                fetchAllBeers()
            case .collectionView:
                view.addSubview(collectionView)
                
                collectionView.pinToFourEdges(in: view)
                
                fetchAllImages()
        }
    }
    
    private func fetchAllBeers() {
        store.fetchAllBeverages { [weak self] result in
            guard let self = self else { return }
            
            do {
                let beverages = try result.get()
                self.beverages = beverages
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                self.presentAlert(with: "An error occured", message: error.localizedDescription)
            }
        }
    }
    
    private func fetchAllImages() {
        store.fetchAllBeverageImages { [weak self] result in
            guard let self = self else { return }
            
            do {
                let imageURLs = try result.get()
                self.imageURLs = imageURLs
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch {
                self.presentAlert(with: "An error occured", message: error.localizedDescription)
            }
        }
    }
    
    @objc private func switchView() {
        tableView.removeFromSuperview()
        collectionView.removeFromSuperview()
        switch selection {
            case .tableView: selection = .collectionView
            case .collectionView: selection = .tableView
        }
        configure()
    }
}

extension BeverageList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beverages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BeverageCell.reuseIdentifier, for: indexPath)
        
        guard let beverageCell = cell as? BeverageCell else { fatalError("Couldn't dequeue beverage cell") }
        beverageCell.configure(with: beverages[indexPath.row])
        
        return cell
    }
}

extension BeverageList: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BottleCell.reuseIdentifier, for: indexPath)
        
        guard let bottleCell = cell as? BottleCell else { fatalError("Couldn't dequeu bottle cell") }
        bottleCell.configure(with: imageURLs[indexPath.row])
        
        return cell
    }
}
