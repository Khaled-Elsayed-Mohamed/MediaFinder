import UIKit

class SignInVC: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var SignInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.hidesBackButton = true
        navigationItem.title = VCs.signInVC
        

        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func goToTabelView() {
        self.navigationController?.pushViewController(tableViewVC, animated: true)
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        let decoded = UserDefaults.standard.object(forKey: "user") as! Data
        let user = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? User
        if user!.email == emailTextField.text && user?.password == passwordTextField.text {
            goToTabelView()
        } else {
            sender.shake()
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        let signUpVC = UIStoryboard.init(name: Storyboards.main, bundle: nil).instantiateViewController(withIdentifier: VCs.signUpVC) as! SignUpVC
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}

extension SignInVC: UITextFieldDelegate {
    @objc func textFieldDidChange(_ sender: UITextField) {
        if emailTextField.text == "" || passwordTextField.text == "" {
            self.SignInButton.isEnabled = false;
        }else{
            self.SignInButton.isEnabled = true;
        }
    }
}
