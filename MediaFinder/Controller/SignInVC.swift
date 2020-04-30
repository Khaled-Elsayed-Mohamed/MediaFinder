import UIKit

class SignInVC: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var SignInButton: UIButton!
    
    var database = DatabaseManager.shared()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true
        navigationItem.title = VCs.signInVC
        
        
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func goToTabBar() {
        
        let tabBar = TabBarVC()
        navigationController?.pushViewController(tabBar, animated: true)
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        if database.listAccounts(email: emailTextField.text!, password: passwordTextField.text!) == true {
            goToTabBar()
            let def = UserDefaults.standard
            def.set(true, forKey: "is_authenticated")
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
