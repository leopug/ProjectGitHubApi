import UIKit

class FollowerListVC: UIViewController {

    var username : String!
    var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectioView()
        configureViewController()
        getFollowers()
    }

    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureCollectioView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemPink
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func createThreeColumnFlowLayout()-> UICollectionViewFlowLayout {
        
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let avaliableWidth = width - (padding*2) - (minimumItemSpacing*2)
        let itemWidth = avaliableWidth/3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    func getFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            
            switch result {
            case .success(let followers):
                print("\(followers.count) = followers count")
                print(followers)
            case .failure(let errorMessage):
                self.presentGHAAlertOnMainThread(title: "Error", message: errorMessage.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
}
