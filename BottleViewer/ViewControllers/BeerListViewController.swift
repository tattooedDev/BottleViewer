//
//  BeerListViewController.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 03.09.20.
//

import UIKit

final class BeerListViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = BeveragesTableView(frame: .zero, style: .insetGrouped)
        
        tableView.dataSource = self
        
        return tableView
    }()
    
    private let store = BeverageStore.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        fetchAllBeverages()
    }
    
    private func configure() {
        title = "Beers"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        
        tableView.pinToFourEdges(in: view)
        
        store.delegate = self
    }
    
    private func fetchAllBeverages() {
        store.fetchAllBeverages { [weak self] result in
            guard let self = self else { return }
            
            do {
                try result.get()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                DispatchQueue.main.async {
                    self.presentAlert(with: "An error occured fetching the beverages", message: error.localizedDescription)                    
                }
            }
        }
    }
}

extension BeerListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.allBeverages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BeverageCell.reuseIdentifier, for: indexPath)
        
        guard let beverageCell = cell as? BeverageCell else { fatalError("Couldn't dequeue beverage cell") }
        beverageCell.configure(with: store.allBeverages[indexPath.row])
        
        return cell
    }
}

extension BeerListViewController: BeverageStoreDelegate {
    func beverageStoreDidFilterBeverages(_ beverageStore: BeverageStore) {
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        tableView.reloadData()
    }
    
    func beverageStoreDidSortBeverages(_ beverageStore: BeverageStore) {
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        tableView.reloadData()
    }
}
