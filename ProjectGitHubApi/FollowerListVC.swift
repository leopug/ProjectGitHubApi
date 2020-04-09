//
//  FollowerListVC.swift
//  ProjectGitHubApi
//
//  Created by Ana Caroline de Souza on 09/04/20.
//  Copyright © 2020 Leo Corp. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {

    var username : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true

    }

}
