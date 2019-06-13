//
//  RoundImageView.swift
//  HappyPawsiOS
//
//  Created by Carlo Aguilar on 6/13/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height/2
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
