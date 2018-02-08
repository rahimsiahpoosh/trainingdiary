//
//  ViewController.swift
//  TrainingDiary
//
//  Created by Rahim Siahpoosh on 2018-02-03.
//  Copyright © 2018 Rahim Siahpoosh. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    let uid = UserDefaults().string(forKey: "UID")
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    }


    
    @IBAction func login(_ sender: Any) {
        
        if (emailTextField.text?.isEmpty)! && (passwordTextField.text?.isEmpty)! {
            
            let alert = UIAlertController(title: "ALERT", message: "Type in Email and Password.", preferredStyle: UIAlertControllerStyle.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        } else if (emailTextField.text?.isEmpty)! {
            
            let alert = UIAlertController(title: "ALERT", message: "Type in Email.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if (passwordTextField.text?.isEmpty)! {
            
            let alert = UIAlertController(title: "ALERT", message: "Type in Password.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                if let error = error{
                    print(error)
                }else{
                    self.performSegue(withIdentifier: "toDiaries", sender: nil)
                }
            }
        }
    }
}

