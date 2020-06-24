//
//  UserInfoVC.swift
//  ProjectGitHubApi
//
//  Created by Ana Caroline de Souza on 05/05/20.
//  Copyright © 2020 Leo Corp. All rights reserved.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didRequestFollowers(for username: String)
}

class UserInfoVC: GHADataLoadingVC {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GHABodyLabel(textAlignment: .center)
    var itemViews : [UIView] = []
    
    var username: String!
    weak var delegate: UserInfoVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScrollView()
        configureViewController()
        layoutUI()
        getUserInfo()
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)

        NSLayoutConstraint.activate([ // its necessary to set the width and the height for the contentView inside scrollView
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
        
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            
            guard let `self` = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElements(with: user) }
            case .failure(let error):
                self.presentGHAAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureUIElements(with user: User) {
        let repoItemVC = GHARepoItemVC(user: user, delegate: self)
        
        let followerItemVC = GHAFollowerItemVC(user: user, delegate: self)
        
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.add(childVC: GHAUserInfoHeaderVC(user: user), to: self.headerView)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    func layoutUI(){
        
        itemViews = [headerView,itemViewOne,itemViewTwo, dateLabel]
        let padding : CGFloat = 20
        let itemHeight : CGFloat = 140
        
        
        for itemView in itemViews {
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
}

extension UserInfoVC: GHAFollowerItemVCDelegate {
    func didTapGetFollowers(for user: User) {
        delegate.didRequestFollowers(for: user.login)
        
    }
}

extension UserInfoVC: GHARepoItemVCDelegate {
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGHAAlertOnMainThread(title: "Invalid URL", message: "User's URL are invalid", buttonTitle: "Ok")
            return
        }
        presentSafariVC(with: url)
    }
}
