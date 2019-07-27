//
//  ContainerVC.swift
//  rideshare-development
//
//  Created by Ayush Munot on 26/07/19.
//  Copyright © 2019 Ayush Munot. All rights reserved.
//

import UIKit
import QuartzCore
enum SlideOutState {
    case collapsed
    case leftPanelExpanded
}
enum ShowWhichVC {
    case homeVC
    case paymentVC
}
var showVC: ShowWhichVC = .homeVC

class ContainerVC: UIViewController {
    var homeVC: HomeVC!
    var currentState: SlideOutState = .collapsed

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func initCenter(screen: ShowWhichVC) {
        var presentingController: UIViewController
        showVC = screen
        if homeVC == nil {
            homeVC = UIStoryboard.homeVC()
            homeVC.delegate = self
        }
    }
}
extension ContainerVC: CenterVCDelegate {
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .leftPanelExpanded)
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        animateLeftPanel(shouldExapand: notAlreadyExpanded)
    }
    func addLeftPanelViewController() {
        <#code#>
    }
    func animateLeftPanel(shouldExapand: Bool) {
        <#code#>
    }
}
private extension UIStoryboard {
    class func mainStoryboard()  -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    class func leftViewController() -> LeftSidePanelVC? {
        return mainStoryboard().instantiateViewController(withIdentifier: "LeftSidePanelVC") as? LeftSidePanelVC
    }
    class func homeVC() -> HomeVC? {
        return mainStoryboard().instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
    }
}
