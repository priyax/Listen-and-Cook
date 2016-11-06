//
//  LoginViewController.swift
//  textToTableViewController
//
//  Created by Priya Xavier on 10/6/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        
        
        if !Utility.isValidEmail(emailAddress: emailField.text!) {
            Utility.showAlert(viewController: self, title: "Login Error", message: "Please enter a valid email address.")
            return
        }

      //  spinner.startAnimating()

        let email = emailField.text!
        let password = passwordField.text!
        
        BackendlessManager.sharedInstance.loginUser(email: email, password: password,
            completion: {
            
              //  self.spinner.stopAnimating()
                
                self.performSegue(withIdentifier: "gotoSavedRecipesFromLogin", sender: sender)
            },
            
            error: { message in
                
               // self.spinner.stopAnimating()
                
                Utility.showAlert(viewController: self, title: "Login Error", message: message)
            })
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        signInBtn.isEnabled = false
        emailField.addTarget(self, action: #selector(textFieldChanged(textField:)), for: UIControlEvents.editingChanged)
         passwordField.addTarget(self, action: #selector(textFieldChanged(textField:)), for: UIControlEvents.editingChanged)
        self.emailField.delegate = self
        self.passwordField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Hide Keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Presses return key to exit keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return (true)
    }
    
    func textFieldChanged(textField: UITextField) {
        
        if emailField.text == "" || passwordField.text == "" {
            signInBtn.isEnabled = false
        } else {
            signInBtn.isEnabled = true
        }
    }
    
}
