//
//  Date + Ext.swift
//  GHFollowers
//
//  Created by Дмитрий Папушин on 12.08.2020.
//  Copyright © 2020 Дмитрий Папушин. All rights reserved.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
    
}
