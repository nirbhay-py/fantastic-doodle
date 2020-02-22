import Foundation
class GoogleUser{
    var name:String;
    var email:String;
    var givenName:String;
    var isGuest:Bool;
    var photoURL:String
    var hasPledged:Bool;
    init(name:String,email:String,givenName:String,isGuest:Bool,photoURL:String,hasPledged:Bool) {
        self.name = name;
        self.email = email;
        self.givenName = givenName;
        self.isGuest = isGuest;
        self.photoURL = photoURL;
        self.hasPledged = hasPledged
    }
}

