//
//  UserInfoVC.swift
//  ProjectGitHubApi
//
//  Created by Ana Caroline de Souza on 05/05/20.
//  Copyright © 2020 Leo Corp. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemPink
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        
        print(username!)
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            
            guard let `self` = self else { return }
            
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                self.presentGHAAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
        
    }
    
    @objc func dismissVC() {
        dismiss(animated: true )
    }
   

}
