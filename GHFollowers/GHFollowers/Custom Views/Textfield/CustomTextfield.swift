//
//  CustomTextfield.swift
//  GHFollowers
//
//  Created by Дмитрий Папушин on 27.04.2020.
//  Copyright © 2020 Дмитрий Папушин. All rights reserved.
//

import UIKit

class CustomTextfield: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label // black for white and wite for black mode
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        //keyboardType = .phonePad
        
        returnKeyType = .go
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        
        placeholder = "Enter a username..."
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
} 
