//
//  RoundImageView.swift
//  rideshare-development
//
//  Created by Ayush Munot on 15/07/19.
//  Copyright © 2019 Ayush Munot. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {
    override func awakeFromNib() {
        setupView()
    }

    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }

}
