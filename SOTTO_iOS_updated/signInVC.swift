//
//  signInVC.swift
//  SOTTO_iOS_updated
//
//  Created by Nirbhay Singh on 16/02/20.
//  Copyright © 2020 Nirbhay Singh. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import JGProgressHUD

var globalUser=GoogleUser(name: "Guest", email: "Guest", givenName: "Guest", isGuest:true, photoURL:"Guest",hasPledged:false)
var globalPledgee:Pledgee!

class signInVC: UIViewController,GIDSignInDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        // Do any additional setup after loading the view.
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (authResult, error) in
        if let error = error {
            showAlert(msg: error.localizedDescription)
            return
        }
        let hud = JGProgressHUD.init()
        hud.show(in: self.view,animated: true)
        //MARK:INITIALISING A USER
        let userID = user.userID
        let name = user.profile.name
        let email = user.profile.email
        let givenName = user.profile.givenName
        let photoURL = user.profile.imageURL(withDimension: 150)?.absoluteString
        let userDic = [
              "userID":userID!,
              "givenName":givenName ?? "Empty",
              "name":name!,
              "email":email!,
              "photoURL":photoURL ?? "Empty",
              "Pledgee":false
              ] as [String : Any]
          let strippedEmail = splitString(str:email!, delimiter:".")
          let ref = Database.database().reference().child("user-node").child(strippedEmail)
          ref.setValue(userDic) { (error, ref) -> Void in
              if(error != nil){
                  hud.dismiss()
                  showAlert(msg: error?.localizedDescription ?? "There seems to be something wrong with your connection.")
              }else{
                  globalUser.name = name!
                  globalUser.email = email!
                  globalUser.givenName = givenName!
                  globalUser.isGuest = false
                  globalUser.photoURL = photoURL!
                  globalUser.hasPledged = false
                  hud.dismiss()
                  showSuccess(msg: "Signed in with success!")
                  self.performSegue(withIdentifier: "toDashboard", sender: self)
            }
          }
        }
    }
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    override func viewDidAppear(_ animated: Bool) {
        if(Auth.auth().currentUser != nil){
            print("user not nil")
            let localHud = JGProgressHUD.init()
            localHud.show(in: self.view,animated: true)
            //MARK:FETCH DATA FROM FIREBASE, INITIALISE A USERCLASS OBJECT AND PASS IT IN THE SEGUE
            var email = Auth.auth().currentUser?.email
            email = splitString(str: email!, delimiter: ".")
            let ref = Database.database().reference().child("user-node").child(email!)
            ref.observeSingleEvent(of: .value, with: {(snapshot) in
                let value = snapshot.value as? NSDictionary
                let givenName=value!["givenName"] as! String
                let name = value!["name"] as! String
                let email = value!["email"] as! String
                let photoURL = value!["photoURL"] as! String
                let hasPledged = value!["Pledgee"] as! Bool
                globalUser = GoogleUser(name: name, email: email, givenName: givenName, isGuest: false, photoURL: photoURL,hasPledged: hasPledged)
                localHud.dismiss()
                self.performSegue(withIdentifier: "toDashboard", sender: self)
            }){ (error) in
                print(error.localizedDescription)
                showAlert(msg: error.localizedDescription)
            }
        }
    }
    @IBAction func guestBtnClicked(_ sender: Any) {
         self.performSegue(withIdentifier: "toDashboard", sender: self)
    }
    override func viewWillAppear(_ animated: Bool) {
         navigationController?.setNavigationBarHidden(true, animated: animated)
    }

}
