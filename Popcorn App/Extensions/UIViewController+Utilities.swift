//
//  UIViewController+Utilities.swift
//  Popcorn App
//
//  Created by Lucas Pereira on 12.08.21.
//

import UIKit

extension UIViewController {
    func showErrorAlert(with message: String?) {
        let alert = UIAlertController(title: "Error",
                                      message: message ?? "Unknown error",
                                      preferredStyle: .alert)
        alert.addAction(.init(title: "Ok",
                              style: .default,
                              handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
