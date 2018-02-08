//
//  DiaryDetailVC.swift
//  TrainingDiary
//
//  Created by Rahim Siahpoosh on 2018-02-08.
//  Copyright © 2018 Rahim Siahpoosh. All rights reserved.
//

import UIKit

class DiaryDetailVC: UIViewController {

    @IBOutlet weak var subjectLabel: UILabel!
    
    @IBOutlet weak var diaryTextView: UITextView!
    
    var detailDiary:GymModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let diaryDetail = detailDiary {
            subjectLabel.text = diaryDetail.subject
            diaryTextView.isEditable = false
            diaryTextView.text = diaryDetail.diary
        } else {
            print("knas")
        }

    }

}
