//
//  pledge2VC.swift
//  SOTTO_iOS_updated
//
//  Created by Nirbhay Singh on 16/02/20.
//  Copyright © 2020 Nirbhay Singh. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD
import MessageUI

class pledge2VC: UIViewController,MFMailComposeViewControllerDelegate{
    let hud = JGProgressHUD.init()
    @IBOutlet weak var heartS: UISwitch!
    @IBOutlet weak var lungsS: UISwitch!
    @IBOutlet weak var kidneysS: UISwitch!
    @IBOutlet weak var liverS: UISwitch!
    @IBOutlet weak var pancreasS: UISwitch!
    @IBOutlet weak var corneasS: UISwitch!
    @IBOutlet weak var skinS: UISwitch!
    @IBOutlet weak var bonesS: UISwitch!
    @IBOutlet weak var valvesS: UISwitch!
    @IBOutlet weak var vesselsS: UISwitch!
    var organs:[String]=[]
    var tissues:[String]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func submit(_ sender: Any) {
        if(heartS.isOn){
            organs.append("Heart")
        }
        if(lungsS.isOn){
            organs.append("Lungs")
        }
        if(kidneysS.isOn){
            organs.append("Kidneys")
        }
        if(liverS.isOn){
            organs.append("Liver")
        }
        if(pancreasS.isOn){
            organs.append("Pancreas")
        }
        if(corneasS.isOn){
            tissues.append("Corneas")
        }
        if(skinS.isOn){
            tissues.append("Skin")
        }
        if(bonesS.isOn){
            tissues.append("Bones")
        }
        if(valvesS.isOn){
            tissues.append("Heart Valves")
        }
        if(vesselsS.isOn){
            tissues.append("Blood vessels")
        }
        if(organs.count==0 && tissues.count==0){
            showAlert(msg: "You must select at least one organ or tissue to donate.")
        }else{
            globalPledgee.organsToDonate = organs
            globalPledgee.tissuesToDonate = tissues
            hud.show(in: self.view)
            let organDic = [
                           "Given-name":globalUser.givenName,
                           "Email":globalUser.email,
                           "Google-name":globalUser.name,
                           "Blood-group":globalPledgee.bloodType,
                           "Full-legal-name":globalPledgee.name,
                           "Address":globalPledgee.address,
                           "Birthdate":globalPledgee.birthdate,
                           "Organs":organs,
                           "Tissues":tissues
                           ] as [String : Any]
            let ref = Firebase.Database.database().reference().child("pledges-node").childByAutoId()
            ref.setValue(organDic) {(error, ref) -> Void in
                if(error==nil){
                    globalUser.hasPledged=true
                    let ref = Firebase.Database.database().reference().child("user-node").child(splitString(str: globalUser.email, delimiter: "."))
                    let updates = ["Pledgee":true]
                    ref.updateChildValues(updates) {(error,ref) -> Void in
                        if(error==nil){
                            showSuccess(msg: "You have successfully made a pledge!")
                            self.hud.dismiss()
                            self.performSegue(withIdentifier: "back", sender: nil)
                        }else{
                            showAlert(msg: error!.localizedDescription)
                            self.hud.dismiss()
                        }
                    }
                }else{
                    showAlert(msg: error!.localizedDescription)
                    self.hud.dismiss()
                }
                
            }
        }
        
    }
}
