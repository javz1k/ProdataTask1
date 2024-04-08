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
        print(urlString!)
        

        webView.load(URLRequest(url:URL(string:"https://www.youtube.com")!))

        let defaultURLString = "https://www.google.com"
        if let urlString = urlString, let url = URL(string: urlString) ?? URL(string: defaultURLString) {
            let request = URLRequest(url: url)
            print("Request URL: \(request.url?.absoluteString ?? "nil")")
            print("Request HTTP Method: \(request.httpMethod ?? "nil")")
            webView.load(request)
        } else {
            print("Invalid URL")
        }

        
       }
}
