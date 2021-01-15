//
//  UIhelper.swift
//  GHFollowers
//
//  Created by Дмитрий Папушин on 06.05.2020.
//  Copyright © 2020 Дмитрий Папушин. All rights reserved.
//

import UIKit

struct UIhelper {
    
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        
        let flowLayout = UICollectionViewFlowLayout()
        let width = view.bounds.width / 3
        let padding: CGFloat = 10
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: width - 14 , height: width + 40)
        
        return flowLayout
        
        
    }
}

// MARK: - The old way of doing that

//                let width = view.bounds.width // as a parametr from above
//                let padding: CGFloat = 12
//                let minimumItemsSpacing: CGFloat = 10
//                let availibleWidth = width - (padding * 2) - (minimumItemsSpacing * 2)
//                let itemWidth = availibleWidth / 3
//
//                let flowLayout = UICollectionViewFlowLayout()
//                flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
//                flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
