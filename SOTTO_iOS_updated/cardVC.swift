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
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var organsLbl: UILabel!
    @IBOutlet weak var tissuesLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if(!globalUser.hasPledged){
            showAlert(msg: "You have not yet made a pledge.")
            self.performSegue(withIdentifier: "toDonor", sender: self)
        }else if(globalUser.isGuest)
        {
            showAlert(msg: "You need to sign in to view your card.")
        }
        else{
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
            emailLbl.text = globalPledgee.email
            organsLbl.text = organsStr
            tissuesLbl.text = tissuesStr
            hud.dismiss()
        }
    }
}
