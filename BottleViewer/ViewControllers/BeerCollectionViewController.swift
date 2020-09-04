//
//  BeerCollectionViewController.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 03.09.20.
//

import UIKit

final class BeerCollectionViewController: UIViewController {

    lazy var collectionView: BottleCollectionView = {
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
    
    private let store = BeverageStore.shared
    private var imageURLs = [URL]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        fetchAllImages()
    }
    
    private func configure() {
        title = "Beers"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(collectionView)
        
        collectionView.pinToFourEdges(in: view)
        
        store.delegate = self
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
                DispatchQueue.main.async {
                    self.presentAlert(with: "An error occured", message: error.localizedDescription)                    
                }
            }
        }
    }
}

extension BeerCollectionViewController: UICollectionViewDataSource {
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

extension BeerCollectionViewController: BeverageStoreDelegate {
    func beverageStoreDidFilterBeverages(_ beverageStore: BeverageStore) {
        collectionView.reloadData()
    }
    
    func beverageStoreDidSortBeverages(_ beverageStore: BeverageStore) {
        collectionView.reloadData()
    }
}
