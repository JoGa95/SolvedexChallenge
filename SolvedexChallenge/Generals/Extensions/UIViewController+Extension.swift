//
//  UIViewController+Extension.swift
//  SolvedexChallenge
//
//  Created by Jorge Garay on 25/01/24.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showLoader() {
        DispatchQueue.main.async {
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            let alert = UIAlertController(title: nil, message: AppStrings.loading.rawValue, preferredStyle: .alert)
            
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.color = .black
            loadingIndicator.style = UIActivityIndicatorView.Style.medium
            loadingIndicator.startAnimating();
            alert.view.addSubview(loadingIndicator)
            self.present(alert, animated: false, completion: nil)
        }
    }
    
    func hideLoder() {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
    
    func showAlert(message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: self.title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: AppStrings.ok.rawValue, style: .default, handler: {action in }))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
