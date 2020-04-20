//
//  GHAAvatarImageView.swift
//  ProjectGitHubApi
//
//  Created by Ana Caroline de Souza on 20/04/20.
//  Copyright © 2020 Leo Corp. All rights reserved.
//

import UIKit

class GHAAvatarImageView: UIImageView {

   let placeholderImage = UIImage(named: "avatar-placeholder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage!
        translatesAutoresizingMaskIntoConstraints = false 
        
    }

}