import UIKit

class GHAFollowerItemVC: GHAItemInfoVC { // GHAFollowerItemVC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos , withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        
        actionButton.set(backgroundColor: .systemPurple, title: "Git Followers")
        
    }
    
    override func actionButtonTapped() {
        
        guard user.followers != 0 else {
            presentGHAAlertOnMainThread(title: "No Followers", message: "This user have ZERO followers", buttonTitle: "Ok ")
            return
        }
        
        delegate.didTapGetFollowers(for: user)
        dismissVC()
        }
    }
