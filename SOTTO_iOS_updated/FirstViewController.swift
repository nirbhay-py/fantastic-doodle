//
//  FirstViewController.swift
//  SOTTO_iOS_updated
//
//  Created by Nirbhay Singh on 16/02/20.
//  Copyright © 2020 Nirbhay Singh. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var c1: NSLayoutConstraint!
    @IBOutlet weak var c2: NSLayoutConstraint!
    @IBOutlet weak var c3: NSLayoutConstraint!
    @IBOutlet weak var c4: NSLayoutConstraint!
    @IBOutlet weak var c5: NSLayoutConstraint!
    @IBOutlet weak var c6: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)

        UIView.animate(withDuration: 0.7, animations: {
            self.c1.constant -= self.view.bounds.width
            self.c2.constant -= self.view.bounds.width
            self.c3.constant -= self.view.bounds.width
            self.c4.constant -= self.view.bounds.width
            self.c5.constant -= self.view.bounds.width
            self.c6.constant -= self.view.bounds.width
        })

    }
    override func viewDidAppear(_ animated: Bool) {
        animateWithKeyFrames()
    }
    func animateWithKeyFrames(){
        UIView.animateKeyframes(withDuration: 1, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.16, relativeDuration: 0.16, animations: {
                self.c6.constant += self.view.bounds.width
                self.view.layoutIfNeeded()
            })
            UIView.addKeyframe(withRelativeStartTime: 0.32, relativeDuration: 0.16, animations: {
                 self.c1.constant += self.view.bounds.width
                 self.view.layoutIfNeeded()
            })
            UIView.addKeyframe(withRelativeStartTime: 0.48, relativeDuration: 0.16, animations: {
                self.c2.constant += self.view.bounds.width
                self.view.layoutIfNeeded()
            })
            UIView.addKeyframe(withRelativeStartTime: 0.64, relativeDuration: 0.16, animations: {
               self.c3.constant += self.view.bounds.width
               self.view.layoutIfNeeded()
            })
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.16, animations: {
                self.c4.constant += self.view.bounds.width
                self.view.layoutIfNeeded()
            })
            UIView.addKeyframe(withRelativeStartTime: 0.96, relativeDuration: 0.16, animations: {
                self.c5.constant += self.view.bounds.width
                self.view.layoutIfNeeded()
            })
        }) { (completed) in
            print("done animating.")
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }


}

