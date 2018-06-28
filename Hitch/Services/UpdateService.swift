//
//  UpdateService.swift
//  Hitch
//
//  Created by Lasse Silkoset on 27.06.2018.
//  Copyright © 2018 Lasse Silkoset. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Firebase

class UpdateService {
    
    //Making singleton so it is available for the entire lifecycle of the app when it gets instatiated
    static var instance = UpdateService()
    
    func updateUserLocation(withCoordinate coordinate: CLLocationCoordinate2D) {
        //observing single event, meaning it will run one time and stop. since we are relaying on the mapview updating, not firebase monitoring for changes.
        DataService.instance.REF_USERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let userSnapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for user in userSnapshot {
                    if user.key == Auth.auth().currentUser?.uid {
                        DataService.instance.REF_USERS.child(user.key).updateChildValues(["coordinate" : [coordinate.latitude, coordinate.longitude]])
                    }
                }
            }
        })
    }
    
    func updateDriverLocation(withCoordinate coordinate: CLLocationCoordinate2D) {
        DataService.instance.REF_DRIVERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let driverSnapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for driver in driverSnapshot {
                    if driver.key == Auth.auth().currentUser?.uid {
                        if driver.childSnapshot(forPath: "isPickupModeEnabled").value as? Bool == true {
                        DataService.instance.REF_DRIVERS.child(driver.key).updateChildValues(["coordinate" : [coordinate.latitude, coordinate.longitude]])
                        }
                    }
                }
            }
        })
    }
    
}
