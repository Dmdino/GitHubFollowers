//
//  UIViewController + Ext.swift
//  GHFollowers
//
//  Created by Дмитрий Папушин on 02.05.2020.
//  Copyright © 2020 Дмитрий Папушин. All rights reserved.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController {
    
    func presentCustomAlertOnMaimThread(title: String, message: String, buttonTitle: String) {
        
        DispatchQueue.main.async {
            
            let alertVC = AlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true, completion: nil)
            
        }
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true, completion: nil)
    }
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {containerView.alpha = 0.8}
        
        let activityUndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityUndicator)
        activityUndicator.centerInSuperview()
        activityUndicator.startAnimating()
    }
    
    func dismissloadingActivityIndicator() {
        
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil

        }
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateview = GFEmptyStateView(message: message)
        emptyStateview.frame = view.bounds
        
        view.addSubview(emptyStateview)
    }
    
}
