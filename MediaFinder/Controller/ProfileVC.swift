import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailTextField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let def = UserDefaults.standard
        def.set(true, forKey: "is_authenticated") // save true flag to UserDefaults
        
        navigationItem.hidesBackButton = false
        profilePictureImageView.layer.cornerRadius = profilePictureImageView.frame.size.height/2
        profilePictureImageView.clipsToBounds = true
        
        
        
        let decoded = UserDefaults.standard.object(forKey: "user") as! Data
        let user = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? User
        profilePictureImageView.image = user?.profileImage
        nameLabel.text = "User Name:- \(user?.name ?? "")"
        emailTextField.text = "User Email:- \(user?.email ?? "")"
    }
   
    
    @IBAction func signOutButton(_ sender: Any) {
        
        let signInVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        
        let def = UserDefaults.standard
        def.set(false, forKey: "is_authenticated") // save true flag to UserDefaults
        navigationController?.pushViewController(signInVC, animated: true)
        
    }
}

