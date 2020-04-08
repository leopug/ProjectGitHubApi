//
//  GHAButton.swift
//  ProjectGitHubApi
//
//  Created by Ana Caroline de Souza on 08/04/20.
//  Copyright © 2020 Leo Corp. All rights reserved.
//

import UIKit

class GHAButton: UIButton {

 
    override init(frame: CGRect) {
        super.init(frame:frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, title: String){
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure(){
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }

}
