//
//  GFSecondaryLabel.swift
//  GHFollowers
//
//  Created by Дмитрий Папушин on 23.06.2020.
//  Copyright © 2020 Дмитрий Папушин. All rights reserved.
//

import UIKit

class GFSecondaryLabel: UILabel {
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           configure()
       }
       
       init(fontSize: CGFloat) {
           super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
           configure()
           
       }
       
       private func configure() {
           textColor = .secondaryLabel
           adjustsFontSizeToFitWidth = true
           minimumScaleFactor = 0.90
           lineBreakMode = .byTruncatingTail
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

}
