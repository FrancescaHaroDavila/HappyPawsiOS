//
//  CreatePetViewController.swift
//  HappyPawsiOS
//
//  Created by Bryam  on 6/13/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import UIKit

class CreatePetViewController: UIViewController {

    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentController.selectedSegmentIndex = 0
    }
    
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            firstView.isHidden = false
            secondView.isHidden = true
            thirdView.isHidden = true
        } else if sender.selectedSegmentIndex == 1 {
            firstView.isHidden = true
            secondView.isHidden = false
            thirdView.isHidden = true
        } else {
            firstView.isHidden = true
            secondView.isHidden = true
            thirdView.isHidden = false
        }
    }
    

}
