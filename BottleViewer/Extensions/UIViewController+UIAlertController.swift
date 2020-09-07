//
//  UIViewController+UIAlertController.swift
//  BottleViewer
//
//  Created by Dennis Parussini on 03.09.20.
//

import UIKit

extension UIViewController {
    /// Helper method that displays a custom default alert for error messages
    /// - Parameters:
    ///   - title: The title of the alert
    ///   - message: The message of the alert
    func presentAlert(with title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}
