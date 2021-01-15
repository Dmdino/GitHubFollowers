//
//  UIView + Ext.swift
//  GHFollowers
//
//  Created by Дмитрий Папушин on 02.05.2020.
//  Copyright © 2020 Дмитрий Папушин. All rights reserved.
//

import UIKit

extension UIView {
    
   class func setupContainer() -> UIView {
        let view = UIView()
        
        view.backgroundColor = .systemBackground // white in white mode and black in blake mode
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        
        return view
    }
}
