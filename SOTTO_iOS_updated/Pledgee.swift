import Foundation
class Pledgee{
    var name:String;
    var birthdate:String;
    var bloodType:String;
    var address:String;
    var email:String;
    var organsToDonate:[String];
    var tissuesToDonate:[String];
    init(name:String,birthdate:String,bloodType:String,address:String,email:String, organsToDonate:[String], tissuesToDonate:[String]) {
        self.name = name;
        self.birthdate = birthdate;
        self.bloodType = bloodType;
        self.address = address;
        self.email = email;
        self.organsToDonate = organsToDonate
        self.tissuesToDonate = tissuesToDonate
    }
}

