//
//  ViewController.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 03.09.20.
//

import UIKit

final class ViewController: UIViewController {

    private let beveragesStore = BeverageStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        beveragesStore.fetchAllBeverages { result in
            do {
                let beverages = try result.get()
                print(beverages)
            } catch {
                print(error)
            }
        }
    }
}
