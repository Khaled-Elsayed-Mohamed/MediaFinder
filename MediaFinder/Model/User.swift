import Foundation
import UIKit

var flag: Bool = false


class User: NSObject, NSCoding {
    @objc var name: String!
    @objc var email: String!
    @objc var password: String!
    @objc var profileImage: UIImage!
    @objc var address: String!
    
    init(name: String, email: String, password: String, profileImage: UIImage, address: String) {
        self.name = name
        self.email = email
        self.password = password
        self.profileImage = profileImage
        self.address = address
    }
    //    UserDefaults.standard.set(value , forKey: "")
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let email = aDecoder.decodeObject(forKey: "email") as! String
        let password = aDecoder.decodeObject(forKey: "password") as! String
        let profileImage = aDecoder.decodeObject(forKey: "profileImage") as! UIImage
        let address = aDecoder.decodeObject(forKey: "address") as! String
        
        self.init(name: name, email: email, password: password, profileImage: profileImage, address: address)
    }
    //    UserDefaults.standard.string(forKey: "")
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(profileImage, forKey: "profileImage")
        aCoder.encode(address, forKey: "address")
    }
    
}


