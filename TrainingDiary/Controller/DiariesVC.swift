//
//  DiariesVC.swift
//  TrainingDiary
//
//  Created by Rahim Siahpoosh on 2018-02-04.
//  Copyright © 2018 Rahim Siahpoosh. All rights reserved.
//

import UIKit
import Firebase

class DiariesVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewGymDiaries: UITableView!
    
    var ref: DatabaseReference!
    var gymList = [GymModel]()
    var gymListTemp = [GymModel]()
    let uid = UserDefaults().string(forKey: "UID")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        ref = Database.database().reference().child("Diaries").child(uid!).child("objects")
        ref.observe(DataEventType.value) {  (snapshot) in
            if snapshot.childrenCount > 0 {
                self.gymList.removeAll()
                for gymDiaries in snapshot.children.allObjects as! [DataSnapshot] {
                    let gymDiaryObject = gymDiaries.value as? [String : Any]
                    let gymSubject = gymDiaryObject?["subject"]
                    let gymId = gymDiaryObject?["id"]
                    print(snapshot)
                    let gymDiary = GymModel(id: (gymId as! String?)!, subject: (gymSubject as! String?)!)
                    self.gymList.append(gymDiary)
                }
                self.gymList.reverse()
                self.gymListTemp = self.gymList
                self.tableViewGymDiaries.reloadData()
                
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text! == ""{
            gymListTemp = gymList
        } else{
            gymListTemp = gymList.filter({($0.subject?.lowercased().contains(searchBar.text!.lowercased()))!})
        }
        self.tableViewGymDiaries.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gymListTemp.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Creating a cell using the custom class
        let cell = tableView.dequeueReusableCell(withIdentifier: "gymCell", for: indexPath) as! GymCell
        
        //gymDiary is typed as GymModel
        let gymDiary: GymModel
        
        //getting the gymdiary of seleceted position
        gymDiary = gymListTemp[indexPath.row]
        cell.subjectLabel.text = gymDiary.subject
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "diaryDetail", sender: indexPath.row)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "diaryDetail" {
            if let diaryDetail = segue.destination as? DiaryDetailVC {
                if let indx = sender as? Int {
                    diaryDetail.detailDiary = gymListTemp[indx]
                }
            }
        }
    }
}

//Glöm inte att lägga till en logout och en sliding menu.
