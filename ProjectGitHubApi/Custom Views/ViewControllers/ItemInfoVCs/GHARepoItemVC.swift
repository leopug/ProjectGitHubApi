//
//  GHARepoItemVC.swift
//  ProjectGitHubApi
//
//  Created by Ana Caroline de Souza on 13/05/20.
//  Copyright © 2020 Leo Corp. All rights reserved.
//

import UIKit

class GHARepoItemVC: GHAItemInfoVC {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos , withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
        
    }
    
}
