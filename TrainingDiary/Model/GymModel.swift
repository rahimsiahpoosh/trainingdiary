//
//  GymModel.swift
//  TrainingDiary
//
//  Created by Rahim Siahpoosh on 2018-02-05.
//  Copyright © 2018 Rahim Siahpoosh. All rights reserved.
//

import Foundation

class GymModel {
    var id: String?
    var subject: String?
    
    init(id: String, subject: String) {
        self.id = id
        self.subject = subject
    }
}