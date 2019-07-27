//
//  HomeVC.swift
//  rideshare-development
//
//  Created by Ayush Munot on 24/06/19.
//  Copyright © 2019 Ayush Munot. All rights reserved.
//

import UIKit
import MapKit

class HomeVC: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var actionBtn: RoundedShadowButton!
    
    var delegate: CenterVCDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate  = self
        // Do any additional setup after loading the view.
    }

    @IBAction func actionBtnWasPressed(_ sender: Any) {
        actionBtn.animateButton(shouldLoad: true, withMessage: nil)
    }
    
}

