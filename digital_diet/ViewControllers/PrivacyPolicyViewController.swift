//
//  PrivacyPolicyViewController.swift
//  digital_diet
//
      
//

import UIKit
import WebKit

class PrivacyPolicyViewController: BaseViewController {
    
    @IBOutlet weak var webVIew: WKWebView!
    var urlString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webVIew.navigationDelegate = self
        
        if urlString != "" {
            let myURL = URL(string: urlString)
            let myRequest = URLRequest(url: myURL!)
            webVIew.load(myRequest)
        }
       
    }
    
}

extension PrivacyPolicyViewController:  WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.showCustomLoader()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.removeCustomLoader()
    }
    
}

