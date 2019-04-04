//
//  ViewController.swift
//  ApiSearchItunes
//
//  Created by Brieuc Caillot on 29/03/2019.
//  Copyright © 2019 Brieuc Caillot. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    
    func showAlert(message:String)
    {
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBOutlet weak var emailInput: UITextField! {
        didSet {
            emailInput.tintColor = UIColor.lightGray
            emailInput.setIcon(UIImage(named: "icon-user")!)
        }
    }
    
    @IBOutlet weak var passwordInput: UITextField! {
        didSet {
            passwordInput.tintColor = UIColor.lightGray
            passwordInput.setIcon(UIImage(named: "icon-password")!)
        }
    }
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBAction func btnSignUpClicked(_ sender: Any) {
        //for signup new user
        if ((emailInput.text == "") || (passwordInput.text == "")) {
            self.showAlert(message: "All fields are mandatory!")
            return
        } else {
            Auth.auth().createUser(withEmail: self.emailInput.text!, password: passwordInput.text!) {
                (authResult, error) in
                // ...
                if ((error == nil)) {
                    self.showAlert(message: "Signup Successfully!")
                } else {
                    self.showAlert(message: "<#T##String#>")
                }
            }
        }
    }

    @IBAction func btnSignedInClicked(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailInput.text!, password: passwordInput.text!) { (user, error) in
            // ...
            if(error == nil )
            {
                if let user = user {
                    _ = user.user.displayName
                    let user_email = user.user.email
                    print(user_email!)
                }
                self.performSegue(withIdentifier: "musicViewController", sender: self)
      
            }
            else{
                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                    switch errorCode {
                    case.wrongPassword:
                        self.showAlert(message: "You entered an invalid password please try again!")
                        break
                    case.userNotFound:
                        self.showAlert(message: "User not found")
                    default:
                        self.showAlert(message: "Unexpected error \(errorCode.rawValue) please try again!")
                        print("Creating user error \(error.debugDescription)!")
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.signInButton.layer.cornerRadius = 15;
        self.signInButton.clipsToBounds = true;
        
        self.signUpButton.layer.cornerRadius = 15;
        self.signUpButton.clipsToBounds = true;
    }

}

extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
            CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}
