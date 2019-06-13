//
//  UserNameViewController.swift
//  HappyPawsiOS
//
//  Created by Francesca Haro on 6/13/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import UIKit

protocol ProfileNameDelegate: class {
    func restoreBackgroundPassword()
}

/**
 Enum to be used to indicate the mode in which the subviews are going to be animated.
 ````
 case toAppear
 case toDisappear
 ````
 */
private enum SetupMode {
    
    case toAppear
    case toDisappear
}

class UserNameViewController: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        
        self.backView.isUserInteractionEnabled = true
        self.backView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    private func animateSubviews(forMode mode: SetupMode, completionHandler: (() -> Void)? = nil) {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = (mode == .toAppear) ? 1.0 : 0.0
            
        }) { (completed: Bool) in
            completionHandler?()
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.animateSubviews(forMode: .toDisappear, completionHandler: { [unowned self] in
            self.dismiss(animated: false, completion: nil)
        })
        
    }
    
}
