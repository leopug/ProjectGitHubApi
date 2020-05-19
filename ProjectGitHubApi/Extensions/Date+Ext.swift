//
//  Date+Ext.swift
//  ProjectGitHubApi
//
//  Created by Ana Caroline de Souza on 19/05/20.
//  Copyright © 2020 Leo Corp. All rights reserved.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
}
