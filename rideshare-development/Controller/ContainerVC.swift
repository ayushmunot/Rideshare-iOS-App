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
    var leftVC: LeftSidePanelVC!
    var centerController: UIViewController
    var currentState: SlideOutState = .collapsed
    
    var isHidden = false
    let centerPanelExpandedOffset: CGFloat = 160
    
    var tap: UITapGestureRecognizer

    override func viewDidLoad() {
        super.viewDidLoad()
        initCenter(screen: showVC)
    }
    func initCenter(screen: ShowWhichVC) {
        var presentingController: UIViewController
        showVC = screen
        
        if homeVC == nil {
            homeVC = UIStoryboard.homeVC()
            homeVC.delegate = self
        }
        presentingController = homeVC
        
        if let contr = centerController {
            contr.view.removeFromSuperview()
            contr.removeFromParentViewController()
        }
        centerController = presentingController
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    override var prefersStatusBarHidden: Bool {
        return isHidden
    }
}
extension ContainerVC: CenterVCDelegate {
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .leftPanelExpanded)
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    func addLeftPanelViewController() {
        if leftVC == nil {
            leftVC = UIStoryboard.leftViewController()
            addChildSidePanelViewController(sidePanelController: leftVC!)
        }
    }
    func addChildSidePanelViewController(sidePanelController: LeftSidePanelVC) {
        view.insertSubview(sidePanelController.view, at: 0)
        addChild(sidePanelController)
        sidePanelController.didMove(toParent: self)
    }
    @objc func animateLeftPanel(shouldExpand: Bool) {
        if shouldExpand {
            isHidden = !isHidden
            animateStatusBar()
            setupWhiteCoverView()
            currentState = .leftPanelExpanded
            animateCenterPanelExposition(targetPosition: centerController.view.frame.width - centerPanelExpandedOffset)
            
        } else {
            isHidden = !isHidden
            animateStatusBar()
            hideWhiteCoverView()
            animateCenterPanelExposition(targetPosition: 0, completion: { (finished) in
                if finished == true {
                    self.currentState = .collapsed
                    self.leftVC = nil
                }
            })
        }
    }
    func animateCenterPanelExposition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {self.centerController.view.frame.origin.x = targetPosition}, completion: completion)
    }
    
    func setupWhiteCoverView() {
        let whiteCoverView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        whiteCoverView.alpha = 0.0
        whiteCoverView.backgroundColor = UIColor.white
        whiteCoverView.tag = 25
        
        self.centerController.view.addSubview(whiteCoverView)
        UIView.animate(withDuration: 0.2) {
            whiteCoverView.alpha = 0.75
        }
        tap = UITapGestureRecognizer(target: self, action: #selector(animateLeftPanel(shouldExpand:)))
        tap.numberOfTapsRequired = 1
        self.centerController.view.addGestureRecognizer(tap)
    }
    
    func hideWhiteCoverView() {
        centerController.view.removeGestureRecognizer(tap)
        for subView in self.centerController.view.subviews {
            if subView.tag == 25 {
                UIView.animate(withDuration: 0.2, animations: {subView.alpha = 0.0}, completion: {(finished) in
                    subView.removeFromSuperview()
                })
            }
        }
    }
    
    func animateStatusBar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {self.setNeedsStatusBarAppearanceUpdate()
        })
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
