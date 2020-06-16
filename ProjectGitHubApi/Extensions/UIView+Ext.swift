//
//  UIView+Ext.swift
//  ProjectGitHubApi
//
//  Created by Ana Caroline de Souza on 16/06/20.
//  Copyright © 2020 Leo Corp. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views : UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
