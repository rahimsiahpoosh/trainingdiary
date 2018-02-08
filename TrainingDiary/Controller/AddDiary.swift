//
//  AddDiary.swift
//  TrainingDiary
//
//  Created by Rahim Siahpoosh on 2018-02-05.
//  Copyright © 2018 Rahim Siahpoosh. All rights reserved.
//

import UIKit
import Firebase

class AddDiary: UIViewController {

    var ref: DatabaseReference!
    let uid = UserDefaults().string(forKey: "UID")
    
    @IBOutlet weak var subjectField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference().child("Diaries").child(uid!)
        
    }

    @IBAction func save(_ sender: Any) {
        if (subjectField.text?.isEmpty)!{
            let alert = UIAlertController(title: "Alert", message: "Type in subject", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            addGym()
            self.performSegue(withIdentifier: "addedDiary", sender: nil)
        }
    }
    func addGym() {
        let key = ref.childByAutoId().key
        let diary = ["id":key,
                     "subject": subjectField.text! as String]
        ref.child(key).setValue(diary)
    }
}

















