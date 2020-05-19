//
//  String+Ext.swift
//  ProjectGitHubApi
//
//  Created by Ana Caroline de Souza on 19/05/20.
//  Copyright © 2020 Leo Corp. All rights reserved.
//

import Foundation

extension String {
    
    func convertToDate() -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "Not avaliable"}
        return date.convertToMonthYearFormat()
    }
}
