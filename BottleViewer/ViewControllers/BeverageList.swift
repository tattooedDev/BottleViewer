//
//  BeverageList.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 03.09.20.
//

import UIKit

final class BeverageList: UIViewController {
    
    private lazy var tableView: BeveragesTableView = {
        let tableView = BeveragesTableView(frame: .zero, style: .insetGrouped)
        
        tableView.dataSource = self
        
        return tableView
    }()
    
    private let store = BeverageStore()
    private var beverages = [Beverage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        fetchAllBeers()
    }
    
    private func configure() {
        title = "Beers"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        
        tableView.pinToFourEdges(in: view)
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
