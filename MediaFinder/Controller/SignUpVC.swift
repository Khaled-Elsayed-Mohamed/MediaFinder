import UIKit
class SignUpVC: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var joinNowButton: UIButton!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var addressLabel: UILabel!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.title = VCs.signUpVC
        
        profilePictureImageView.layer.cornerRadius = profilePictureImageView.frame.size.height/2
        profilePictureImageView.clipsToBounds = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @IBAction func locationPickButton(_ sender: UIButton) {
        MapKitVC.delegate = self
        present(MapKitVC, animated: true, completion: nil)
    }
// validation manager
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    // validation manager todo:-
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPred.evaluate(with: password)
    }
    // validation manager todo:-
    private func isValidData() -> Bool {
        if let name = nameTextField.text, !name.isEmpty, let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty, let profileImage = profilePictureImageView.image, profileImage != UIImage(named: "unnamed") {
            return true
        }
        return false
    }
    
    
    private func saveData() {
        let user = User(name: nameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, profileImage: profilePictureImageView.image!, address: addressLabel.text ?? "")
        let encodedData = try! NSKeyedArchiver.archivedData(withRootObject: user, requiringSecureCoding: false)
        UserDefaults.standard.set(encodedData, forKey: "user")
        
    }
    
    private func goToSignInVc() {
        let signInVC = UIStoryboard.init(name: Storyboards.main, bundle: nil).instantiateViewController(withIdentifier: VCs.signInVC) as! SignInVC
        self.navigationController?.pushViewController(signInVC, animated: true)
    }
    @IBAction func signInButton(_ sender: Any) {
        goToSignInVc()
    }
    
    @IBAction func joinNowButton(_ sender: UIButton) {
        if isValidData(), isValidEmail(emailTextField.text!), isValidPassword(passwordTextField.text!) {
            saveData()
            goToSignInVc()
        } else {
            sender.shake()
        }
    }
}
    extension SignUpVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBAction func selectImage(_ sender: Any) {
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController( _ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let chosenImage = info[.originalImage] as? UIImage {
            profilePictureImageView.image = chosenImage
            dismiss(animated: true, completion: nil)
        }
        
    }
        
    
}

extension SignUpVC: sendingDataDelegate {
    func sendData(data: String) {
        addressLabel.text = data
    }
}

    
   

