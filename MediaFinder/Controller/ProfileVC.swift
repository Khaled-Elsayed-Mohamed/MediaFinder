import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var database = DatabaseManager.shared()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let def = UserDefaults.standard
        def.set(true, forKey: "is_authenticated") // save true flag to UserDefaults
        
        
        navigationItem.hidesBackButton = false
        profilePictureImageView.circularImage()
        
        let user = database.getIdData()
        
        nameLabel.text = user?.name
        profilePictureImageView.image = UIImage(data: user!.profileImage!)
            
    
    }
    
    
    func hideTabBar() {
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
    }
    
    @IBAction func signOutButton(_ sender: Any) {
        
        hideTabBar()
        
        let def = UserDefaults.standard
        def.set(false, forKey: "is_authenticated") // save true flag to UserDefaults
        let signInVC = UIStoryboard(name: Storyboards.main, bundle: nil).instantiateViewController(withIdentifier: VCs.signInVC) as! SignInVC
        navigationController?.pushViewController(signInVC, animated: true)
        
    }
    
    
    

}

