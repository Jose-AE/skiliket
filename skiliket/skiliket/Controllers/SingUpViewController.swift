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
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var checkboxButton: UIButton!
    
    
    var isChecked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
        
        setupTermsAndConditionsText()

        // Do any additional setup after loading the view.
    }
    
    func setupTermsAndConditionsText() {
            let text = "I agree to the Terms and Conditions and Privacy Policy."
            let attributedString = NSMutableAttributedString(string: text)

            // Enlaces de Términos y Privacidad
            attributedString.addAttribute(.link, value: "terms://", range: NSRange(location: 13, length: 20))
            attributedString.addAttribute(.link, value: "privacy://", range: NSRange(location: 38, length: 14))

            // Color a los enlaces
            attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: NSRange(location: 13, length: 20))
            attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: NSRange(location: 38, length: 14))

            // Formato al UILabel
            termsLabel.attributedText = attributedString
            termsLabel.isUserInteractionEnabled = true
            termsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel(_:))))
        }
        
        @objc func handleTapOnLabel(_ gesture: UITapGestureRecognizer) {
            guard let text = (gesture.view as? UILabel)?.attributedText else { return }
            
            let termsRange = (text.string as NSString).range(of: "Terms and Conditions")
            let privacyRange = (text.string as NSString).range(of: "Privacy Policy")

            let location = gesture.location(in: gesture.view)
            
            if gesture.didTapAttributedTextInLabel(label: termsLabel, inRange: termsRange) {
                performSegue(withIdentifier: "showTerms", sender: self)
            } else if gesture.didTapAttributedTextInLabel(label: termsLabel, inRange: privacyRange) {
                performSegue(withIdentifier: "showPrivacyPolicy", sender: self)
            }
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

    // Extensión para manejar toques en texto dentro de un UILabel
    extension UITapGestureRecognizer {
        func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
            guard let attributedText = label.attributedText else { return false }

            let textStorage = NSTextStorage(attributedString: attributedText)
            let layoutManager = NSLayoutManager()
            let textContainer = NSTextContainer(size: label.bounds.size)
            textContainer.lineFragmentPadding = 0
            textContainer.maximumNumberOfLines = label.numberOfLines
            textContainer.lineBreakMode = label.lineBreakMode
            
            layoutManager.addTextContainer(textContainer)
            textStorage.addLayoutManager(layoutManager)

            let locationOfTouchInLabel = self.location(in: label)
            let textBoundingBox = layoutManager.usedRect(for: textContainer)
            let textContainerOffset = CGPoint(
                x: (label.bounds.size.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                y: (label.bounds.size.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y
            )
            let locationOfTouchInTextContainer = CGPoint(
                x: locationOfTouchInLabel.x - textContainerOffset.x,
                y: locationOfTouchInLabel.y - textContainerOffset.y
            )
            
            let indexOfCharacter = layoutManager.characterIndex(
                for: locationOfTouchInTextContainer,
                in: textContainer,
                fractionOfDistanceBetweenInsertionPoints: nil
            )
            
            return NSLocationInRange(indexOfCharacter, targetRange)
        }
    }
