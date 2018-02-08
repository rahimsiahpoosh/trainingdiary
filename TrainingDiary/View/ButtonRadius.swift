//
//  ButtonRadius.swift
//  TrainingDiary
//
//  Created by Rahim Siahpoosh on 2018-02-05.
//  Copyright © 2018 Rahim Siahpoosh. All rights reserved.
//

import UIKit

class ButtonRadius: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 12
        clipsToBounds = true
    }

}
