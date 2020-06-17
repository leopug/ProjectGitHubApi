import UIKit

protocol GHAFollowerItemVCDelegate: class {
    func didTapGetFollowers(for user: User)
}

class GHAFollowerItemVC: GHAItemInfoVC { // GHAFollowerItemVC
    
    weak var delegate: GHAFollowerItemVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    init(user: User, delegate: GHAFollowerItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
