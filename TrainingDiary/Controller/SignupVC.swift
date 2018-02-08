//
//  SignupVC.swift
//  TrainingDiary
//
//  Created by Rahim Siahpoosh on 2018-02-04.
//  Copyright © 2018 Rahim Siahpoosh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignupVC: UIViewController {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference().child("Diaries")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.8967211843, green: 0.9669813514, blue: 0.8134555221, alpha: 1)
        let btnDone = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(dismissNav))
        btnDone.tintColor = #colorLiteral(red: 0.5747313499, green: 0.8344352841, blue: 0.2513467073, alpha: 1)
        navigationController?.topViewController?.navigationItem.leftBarButtonItem = btnDone
    }

    
    @objc func dismissNav() {
        //self.dismiss(animated: true, completion: nil)
//        self.performSegue(withIdentifier: "backToLogin", sender: nil)
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func createAccount(_ sender: Any) {
        if (nameTextField.text?.isEmpty)! && (emailTextField.text?.isEmpty)! && (passwordTextField.text?.isEmpty)! {
            let alert = UIAlertController(title: "ALERT", message: "Type in, Name, Email and Password.", preferredStyle: UIAlertControllerStyle.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        let name = nameTextField.text?.isEmpty
        if name == true {
            let alert = UIAlertController(title: "ALERT", message: "Type in Name", preferredStyle: UIAlertControllerStyle.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        if (emailTextField.text?.isEmpty)! {
            let alert = UIAlertController(title: "ALERT", message: "Type in Email", preferredStyle: UIAlertControllerStyle.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        if (passwordTextField.text?.isEmpty)! {
            let alert = UIAlertController(title: "ALERT", message: "Type in Password.", preferredStyle: UIAlertControllerStyle.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        } else if (nameTextField.text != nil) && (emailTextField.text != nil) && (passwordTextField.text != nil) {
            createAccount()
            addInfo()
            self.performSegue(withIdentifier: "accountCreated", sender: nil)
        }
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.performSegue(withIdentifier: "backToLogin", sender: nil)
    }
    func createAccount() {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if let error = error {
                print(error)
            }
        }
    }
    func addInfo() {
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
//            UserDefaults().set(uid, forKey: "UID")
            let name = ["name": nameTextField.text! as String]
            ref.child(uid).setValue(name)
            
        }
    }
}
