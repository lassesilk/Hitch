//
//  RoundMapView.swift
//  Hitch
//
//  Created by Lasse Silkoset on 28.06.2018.
//  Copyright © 2018 Lasse Silkoset. All rights reserved.
//

import UIKit
import MapKit

class RoundMapView: MKMapView
{
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        //Need cgcolor for use with custom view
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 10.0
    }
    

}
