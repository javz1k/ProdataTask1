//
//  WebViewController.swift
//  ProdataTask
//
//  Created by Cavidan Mustafayev on 05.04.24.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var urlString:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        makeRequest(urlString:urlString ?? "https://developer.apple.com")
      
    }
    
    fileprivate func makeRequest(urlString:String){
        webView?.load(URLRequest(url:URL(string:urlString)!))
    }
   
}
