import UIKit

class GHADataLoadingVC: UIViewController {
    
    fileprivate var containerView: UIView!

    func showLoadingView() {
        
        containerView = UIView(frame: view.bounds) //fill the whole screen
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.30) {
            self.containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dissmissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    func showEmptyStateView(with message:String, in view: UIView) {
        let emptyStateView = GHAEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true )
    }
    
    
}
