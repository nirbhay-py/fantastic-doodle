//
//  faqVC.swift
//  SOTTO_iOS_updated
//
//  Created by Nirbhay Singh on 16/02/20.
//  Copyright © 2020 Nirbhay Singh. All rights reserved.
//

import UIKit
import WebKit
import JGProgressHUD
class faqVC: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pdfURL = Bundle.main.url(forResource: "Document", withExtension: "pdf", subdirectory: nil, localization: nil)  {
            do {
                let data = try Data(contentsOf: pdfURL)
                let webView = WKWebView(frame:.zero)
                webView.load(data, mimeType: "application/pdf", characterEncodingName:"", baseURL: pdfURL.deletingLastPathComponent())
                webView.contentMode = .scaleAspectFit
                self.view = webView
                
            }
            catch {
                showAlert(msg: "Failed to load pdf")
            }

        }
        // Do any additional setup after loading the view.
    }

}
