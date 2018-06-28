//
//  PassengerAnnotation.swift
//  Hitch
//
//  Created by Lasse Silkoset on 28.06.2018.
//  Copyright © 2018 Lasse Silkoset. All rights reserved.
//

import Foundation
import MapKit

class PassengerAnnotation: NSObject, MKAnnotation
{
    dynamic var coordinate: CLLocationCoordinate2D
    var key: String
    
    init(coordinate: CLLocationCoordinate2D, key: String) {
        self.coordinate = coordinate
        self.key = key
        super.init()
    }
}
