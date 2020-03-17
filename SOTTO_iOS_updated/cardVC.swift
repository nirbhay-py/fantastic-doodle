//
//  cardVC.swift
//  SOTTO_iOS_updated
//
//  Created by Nirbhay Singh on 20/02/20.
//  Copyright © 2020 Nirbhay Singh. All rights reserved.
//

import UIKit
import JGProgressHUD

class cardVC: UIViewController {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var bloodGroupLbl: UILabel!
    @IBOutlet weak var organsLbl: UILabel!
    @IBOutlet weak var tissuesLbl: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if(globalUser.isGuest){
            showAlert(msg: "You have not logged in. In order to make a pledge and view your card, you must be logged in.")
            saveBtn.isHidden = true
        }
        else if(!globalUser.hasPledged){
            showAlert(msg: "You have not yet made a pledge.")
            saveBtn.isHidden = true
        }
        else{
            print(globalPledgee.organsToDonate,globalPledgee.tissuesToDonate)
            let hud = JGProgressHUD.init()
            hud.show(in: self.view)
            var organsStr = ""
            var tissuesStr = ""
            for elem in globalPledgee.organsToDonate{
                organsStr += elem + ", "
            }
            for elem in globalPledgee.tissuesToDonate{
                tissuesStr += elem + ", "
            }
            nameLbl.text = globalUser.name
            addressLbl.text = globalPledgee.address
            bloodGroupLbl.text = globalPledgee.bloodType
            organsLbl.text = organsStr
            tissuesLbl.text = tissuesStr
            hud.dismiss()
        }
    }
    @IBAction func save(_ sender: Any) {
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        // Creates UIImage of same size as view
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        // THIS IS TO SAVE SCREENSHOT TO PHOTOS
        UIImageWriteToSavedPhotosAlbum(screenshot!, nil, nil, nil)
        showSuccess(msg: "Your card is now saved to your library.")
    }
}
