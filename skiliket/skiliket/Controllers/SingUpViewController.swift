//
//  SingUpViewController.swift
//  skiliket
//
//  Created by Rosa Palacios on 17/09/24.
//

import UIKit

class SingUpViewController: UIViewController {
    @IBOutlet weak var singInButton: UIButton!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var checkboxButton: UIButton!
    
    var isChecked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true

        // Do any additional setup after loading the view.
    }
    @IBAction func checkboxButtonPressed(_ sender: Any) {
        if isChecked == false {
            checkboxButton.setImage(UIImage(named: "checkbox"), for: .normal)
            isChecked = true
        }else {
            checkboxButton.setImage(UIImage(named: "unchecked"), for: .normal)
            isChecked = false
        }
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        guard let firstName = firstNameTextField.text, !firstName.isEmpty,
              let lastName = lastNameTextField.text, !lastName.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            showAlert(message: "Please complete all fields")
            return
        }
        if password != confirmPassword {
            showAlert(message: "Passwords do not match")
            return
        }
        
        if !isChecked {
            showAlert(message: "You must agree to the Terms and Conditions")
            return
        }
        
        sendVerificationEmail(to: email)
    }
    
    func sendVerificationEmail(to email: String) {
        print("A verification email has been sent to \(email)")
        
        DispatchQueue.main.async { 
            self.performSegue(withIdentifier: "showVerificationScreen", sender: self)
        }
    }
        
    func showAlert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
