//
//  DiariesVC.swift
//  TrainingDiary
//
//  Created by Rahim Siahpoosh on 2018-02-04.
//  Copyright © 2018 Rahim Siahpoosh. All rights reserved.
//

import UIKit
import Firebase

class DiariesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewGymDiaries: UITableView!
    
    var ref: DatabaseReference!
    var gymList = [GymModel]()
    let uid = UserDefaults().string(forKey: "UID")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference().child("Diaries").child(uid!)
        ref.observe(DataEventType.value) {  (snapshot) in
            if snapshot.childrenCount > 0 {
                self.gymList.removeAll()
                for gymDiaries in snapshot.children.allObjects as! [DataSnapshot] {
                    let gymDiaryObject = gymDiaries.value as? [String : Any]
                    let gymSubject = gymDiaryObject?["subject"]
                    print(gymSubject)
                    let gymId = gymDiaryObject?["id"]
                    print(snapshot)
                    
                 
                    let gymDiary = GymModel(id: (gymId as! String?)!, subject: (gymSubject as! String?)!)
                    self.gymList.append(gymDiary)
                }
                self.gymList.reverse()
                self.tableViewGymDiaries.reloadData()
                
            }
        }
//        ref.observe(DataEventType.value) { (snapshot) in
//            if snapshot.childrenCount > 0 {
//                self.gymList.removeAll()
//                for gymDiaries in snapshot.children.allObjects as! [DataSnapshot] {
//                    let gymDiaryObject = gymDiaries.value as? [String : Any]
//                    let gymSubject = gymDiaryObject?["subject"]
//                    let gymId = gymDiaryObject?["id"]
//                    let gymDiary = GymModel(id: (gymId as! String?)!, subject: (gymSubject as! String?)!)
//                    self.gymList.append(gymDiary)
//                }
//                self.gymList.reverse()
//                self.tableViewGymDiaries.reloadData()
//            }
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gymList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Creating a cell using the custom class
        let cell = tableView.dequeueReusableCell(withIdentifier: "gymCell", for: indexPath) as! GymCell
        
        //gymDiary is typed as GymModel
        let gymDiary: GymModel
        
        //getting the gymdiary of seleceted position
        gymDiary = gymList[indexPath.row]
        cell.subjectLabel.text = gymDiary.subject
        return cell
    }

}

//Glöm inte att lägga till en logout och en sliding menu.
