//
//  BeverageCollectionViewController.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 04.09.20.
//

import UIKit

final class BeverageCollectionViewController: UIViewController {
    
    //MARK: - Collection View
    private lazy var collectionView: UICollectionView = {
        let collectionView = BottleCollectionView(frame: .zero, collectionViewLayout: bottleLayout)
        
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    //MARK: - Collection View Layout
    private lazy var bottleLayout: UICollectionViewLayout = {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    private lazy var detailLayout: UICollectionViewLayout = {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    //MARK: - Button View
    private lazy var buttonView: ButtonView = {
        let view = ButtonView()
        
        return view
    }()
    
    //MARK: - Properties
    private let store = BeverageStore.shared
    private var beverages = [Beverage]()
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        fetchBeverages()
    }
    
    //MARK: - View Configuration
    private func configure() {
        title = "Beers"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .systemBackground
        
        view.addSubViews(buttonView, collectionView)
        
        buttonView.delegate = self
        
        NSLayoutConstraint.activate([
            buttonView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: buttonView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    //MARK: - Fetch all beverages
    private func fetchBeverages() {
        store.fetchAllBeverages { [weak self] result in
            guard let self = self else { return }
            
            do {
                self.beverages = try result.get()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch {
                DispatchQueue.main.async {
                    self.presentAlert(with: "An error occured fetching the beverages", message: error.localizedDescription)
                }
            }
        }
    }
}

//MARK: - UICollectionViewDataSource
extension BeverageCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if case detailLayout = collectionView.collectionViewLayout {
            return beverages.count
        }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if case detailLayout = collectionView.collectionViewLayout {
            return beverages[section].articles.count
        }
        
        return beverages.flatMap({ $0.articles }).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        
        let beverage = beverages[indexPath.section]
        
        switch collectionView.collectionViewLayout {
            case detailLayout:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell.reuseIdentifier, for: indexPath)
                guard let detailCell = cell as? DetailCell else { fatalError("Couldn't dequeue detail cell") }
                detailCell.configure(withName: beverage.name, article: beverage.articles[indexPath.row])
            case bottleLayout:
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: BottleCell.reuseIdentifier, for: indexPath)
                guard let bottleCell = cell as? BottleCell else { fatalError("Couldn't dequeue bottle cell") }
                let articles = beverages.flatMap { $0.articles }
                bottleCell.configure(article: articles[indexPath.row])
            default: fatalError()
        }
        
        return cell
    }
}

//MARK: - ButtonViewDelegate
extension BeverageCollectionViewController: ButtonViewDelegate {
    func buttonViewDidTapViewButton(_ buttonView: ButtonView) {
        switch collectionView.collectionViewLayout {
            case detailLayout:
                collectionView.collectionViewLayout = bottleLayout
                collectionView.reloadData()
            case bottleLayout:
                collectionView.collectionViewLayout = detailLayout
                collectionView.reloadData()
            default: break
        }
    }
    
    func buttonViewDidTapSortButton(_ buttonView: ButtonView) {
        beverages = store.sortedBeverages(beverages)
        collectionView.reloadData()
    }
    
    func buttonViewDidTapFilterButton(_ buttonView: ButtonView) {
        beverages = store.filteredBeverages(beverages)
        collectionView.reloadData()
    }
}
