//
//  SingInViewController.swift
//  skiliket
//
//  Created by Rosa Palacios on 18/09/24.
//

import UIKit

class SingInViewController: UIViewController {
    
    // Conectar los textfields desde el Storyboard
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        // Verificar si los campos están vacíos
        if emailTextField.text?.isEmpty == true && passwordTextField.text?.isEmpty == true {
            showAlert(message: "Please fill in both email and password.")
        } else if emailTextField.text?.isEmpty == true {
            showAlert(message: "Please fill in the email address.")
        } else if passwordTextField.text?.isEmpty == true {
            showAlert(message: "Please fill in the password.")
        } else {
            // Verificar las credenciales
            verifyCredentials(email: emailTextField.text!, password: passwordTextField.text!)
        }
    }
    
    // Función para verificar las credenciales
    func verifyCredentials(email: String, password: String) {
        if email == "admin@skiliket.com" && password == "admin1234" {
            navigateToAdminScreen()
        } else if email == "rosa@gmail.com" && password == "12345678" {
            navigateToUserScreen()
        } else {
            showAlert(message: "User not registered.")
        }
    }
    
    // Función para mostrar la alerta
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // Función para navegar a la pantalla de Admin
    func navigateToAdminScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let adminVC = storyboard.instantiateViewController(withIdentifier: "AdminViewController")
        adminVC.modalPresentationStyle = .fullScreen
        adminVC.modalTransitionStyle = .crossDissolve
        self.present(adminVC, animated: true, completion: nil)
    }
    
    // Función para navegar a la pantalla de User
    func navigateToUserScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let userVC = storyboard.instantiateViewController(withIdentifier: "UserViewController")
        userVC.modalPresentationStyle = .fullScreen
        userVC.modalTransitionStyle = .crossDissolve
        self.present(userVC, animated: true, completion: nil)
    }
}
