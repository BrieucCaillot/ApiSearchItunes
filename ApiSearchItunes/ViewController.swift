//
//  ViewController.swift
//  ApiSearchItunes
//
//  Created by Brieuc Caillot on 29/03/2019.
//  Copyright © 2019 Brieuc Caillot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.signInButton.layer.cornerRadius = 15;
        self.signInButton.clipsToBounds = true;
        
        self.signUpButton.layer.cornerRadius = 15;
        self.signUpButton.clipsToBounds = true;
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
