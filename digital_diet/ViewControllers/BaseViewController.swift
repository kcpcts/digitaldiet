//
//  BaseViewController.swift
//  digital_diet
//
//

import UIKit
import NVActivityIndicatorView

class BaseViewController: UIViewController {
    
    var backgroundView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func forLogout(){
        restartApplicationWith(LoginViewController.instantiate(fromAppStoryboard: .Main))
    }
    
    func restartApplicationWith(_ vc:UIViewController) {
        let viewController = vc
        let navCtrl = UINavigationController(rootViewController: viewController)
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        
        guard
            let window = windowScene?.windows.first,
            let rootViewController = window.rootViewController

        else {
            return
        }

        navCtrl.view.frame = rootViewController.view.frame
        navCtrl.view.layoutIfNeeded()

        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = navCtrl
        })
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWithButtonAction(title: String, message: String, actionTitle: String, actionHandler: ((UIAlertAction) -> Void)? = nil) {
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
           let okayAction = UIAlertAction(title: actionTitle, style: .default) { (action) in
               if let handler = actionHandler {
                   handler(action)
               }
           }
           
           alertController.addAction(okayAction)
           
           present(alertController, animated: true, completion: nil)
       }
    
    
    func showCustomLoader() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            
            
            let frame = CGRect(x: 0, y: 0, width: keyWindow?.frame.width ?? self.view.frame.width, height: keyWindow?.frame.height ?? self.view.frame.height)
            let activityIndicatorView = NVActivityIndicatorView(frame: frame,type: .ballScaleMultiple, color: UIColor.lightGray, padding: 150.0)
            self.backgroundView.addSubview(activityIndicatorView)
            activityIndicatorView.startAnimating()
            keyWindow?.addSubview(self.backgroundView)
        }
    }
    
    func removeCustomLoader() {
        // DispatchQueue.main.async { [weak self] in
        // guard let self = self else { return }
        self.backgroundView.removeAllSubviews()
        // }
    }
    
}

extension UIView {
    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}


extension UIViewController {
    static func instantiate(fromAppStoryboard appStoryboard: StoryBoard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    class var identifier: String {
        return "\(self)"
    }
}
