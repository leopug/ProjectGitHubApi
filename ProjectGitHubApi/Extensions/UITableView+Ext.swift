//
//  UITableView+Ext.swift
//  ProjectGitHubApi
//
//  Created by Leo Corp on 22/06/20.
//  Copyright © 2020 Leo Corp. All rights reserved.
//

import UIKit

extension UITableView {
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
}
