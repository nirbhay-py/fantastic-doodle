//
//  mainTBC.swift
//  AppAuth
//
//  Created by Nirbhay Singh on 17/02/20.
//

import UIKit

class mainTBC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
           navigationController?.setNavigationBarHidden(true, animated: animated)
       }

}
