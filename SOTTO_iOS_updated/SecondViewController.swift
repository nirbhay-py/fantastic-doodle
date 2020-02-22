//
//  SecondViewController.swift
//  SOTTO_iOS_updated
//
//  Created by Nirbhay Singh on 16/02/20.
//  Copyright © 2020 Nirbhay Singh. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController ,UIPickerViewDelegate,UIPickerViewDataSource{
    override func viewDidAppear(_ animated: Bool) {
        if(globalUser.isGuest){
            showAlert(msg: "You must be logged in in order to pledge.")
            self.performSegue(withIdentifier: "toBack", sender: self)
        }
    }
    var stringDate:String!
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var addressTf: UITextField!
    @IBOutlet weak var birthdatePicker: UIDatePicker!
    @IBOutlet weak var picker: UIPickerView!
    var bloodGroup:String=""
    let bloodGroups:[String]=["Not known","A+","A-","B+","B-","AB+","AB-","O+","O-"]
    @IBOutlet weak var mainLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self
        // Do any additional setup after loading the view.
        if(globalUser.hasPledged){
            mainLbl.text = "Hi, "+globalUser.givenName+". You have already made a pledge to be an organ donor. If you want, you can update your information below."
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bloodGroups.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return bloodGroups[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        bloodGroup = bloodGroups[row]
    }
    @IBAction func datePickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        stringDate = dateFormatter.string(from: birthdatePicker.date)
        
    }

    @IBAction func proceedClicked(_ sender: Any) {
        let now = Date()
        let birthday: Date = birthdatePicker.date
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        let age = ageComponents.year!
        if(nameTf.text==""||addressTf.text == ""){
                showAlert(msg: "You cannot leave fields blank!")
        }else if(age<18){
            showAlert(msg: "You must be atleast 18 to register.")
        }else if(addressTf.text!.count<15){
            showAlert(msg: "Your address must contain atleast 15 characters.")
        }else{
            globalPledgee = Pledgee(name: nameTf.text!, birthdate: stringDate, bloodType: bloodGroup, address: addressTf.text!, email: globalUser.email, organsToDonate: [""], tissuesToDonate:[""])
            self.performSegue(withIdentifier: "toPledge2", sender: nil)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

