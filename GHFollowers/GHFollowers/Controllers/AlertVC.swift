//
//  AlertVC.swift
//  GHFollowers
//
//  Created by Дмитрий Папушин on 02.05.2020.
//  Copyright © 2020 Дмитрий Папушин. All rights reserved.
//

import UIKit

class AlertVC: UIViewController {
    
    // MARK: - Properties
    
    let containerView = UIView.setupContainer()
    let titleLabel = CustomTitleLabel(textAligment: .center, fontSize: 20)
    let errorMessageLabel = CustomBodyTitleLabel(textAligment: .center)
    let actionButton = CustomButton(backgroundColor: .systemPink, title: "OK")
   
    // MARK: - Custom initializer
    
    var alerttitle: String?
    var message: String?
    var buttonTitle: String?
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.alerttitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        
        configureContainerView()
        configureTtitleLabel()
        configureActonButton()
        configureMessageLabel()
}
    
    // MARK: - Configure UI
    
    func configureContainerView() {
        
        view.addSubview(containerView)
        containerView.centerInSuperview(size: .init(width: 350, height: 220))
        
    }
    
    func configureTtitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alerttitle ?? "Somthing went wrong"

        titleLabel.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 28))
    }
    
    func configureActonButton() {
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "OK", for: UIControl.State.normal)
        actionButton.addTarget(self, action: #selector(handleAlertButton), for: .touchUpInside)

        actionButton.anchor(top: nil, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 20, right: 20), size: .init(width: 0, height: 44))
    }
    
    @objc func handleAlertButton() {
        dismiss(animated: true, completion: nil)
    }
    
    func configureMessageLabel() {
        containerView.addSubview(errorMessageLabel)
        errorMessageLabel.text = message ?? "Unable to complete request"
        errorMessageLabel.numberOfLines = 4

        errorMessageLabel.anchor(top: titleLabel.bottomAnchor, leading: containerView.leadingAnchor, bottom: actionButton.topAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 8, left: 20, bottom: 12, right: 20))

    }
}

        // another way to constraint
        
//        NSLayoutConstraint.activate([
//
//            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            containerView.widthAnchor.constraint(equalToConstant: 280),
//            containerView.heightAnchor.constraint(equalToConstant: 220)
//
//
//        ])
