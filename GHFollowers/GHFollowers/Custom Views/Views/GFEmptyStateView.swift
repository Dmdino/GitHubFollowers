//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by Дмитрий Папушин on 09.05.2020.
//  Copyright © 2020 Дмитрий Папушин. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIView {
    
    // MARK: - Properties
    
    let messageLabel = CustomTitleLabel(textAligment: .center, fontSize: 28)
    let logoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // MARK: - convenient init
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    // MARK: - Configure UI
    
    func configure() {
        addSubview(messageLabel)
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        messageLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 40, bottom: 0, right: 40), size: .init(width: 0, height: 200))
      
        
        addSubview(logoImageView)
        logoImageView.image = #imageLiteral(resourceName: "empty-state-logo").withRenderingMode(.alwaysOriginal)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
    NSLayoutConstraint.activate([
        logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
        logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
        logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
        logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
    ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
