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
        print(urlString)
        

        if let urlString = urlString, let url = URL(string: urlString) {
               let request = URLRequest(url:url)
               webView.load(request)
           } else {
               print("Invalid URL")
           }
        
       }
}
