//
//  CenterVCDelegate.swift
//  rideshare-development
//
//  Created by Ayush Munot on 26/07/19.
//  Copyright © 2019 Ayush Munot. All rights reserved.
//

import UIKit
protocol CenterVCDelegate {
    func toggleLeftPanel()
    func addLeftPanelViewController()
    func animateLeftPanel(shouldExpand: Bool)
}
