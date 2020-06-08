//
//  GHAAlertContainerView.swift
//  ProjectGitHubApi
//
//  Created by Ana Caroline de Souza on 08/06/20.
//  Copyright © 2020 Leo Corp. All rights reserved.
//

import UIKit

class GHAAlertContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
    }
    
}
