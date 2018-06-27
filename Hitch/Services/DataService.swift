//
//  DataService.swift
//  Hitch
//
//  Created by Lasse Silkoset on 22.06.2018.
//  Copyright © 2018 Lasse Silkoset. All rights reserved.
//

import Foundation
import Firebase

//creating url outside of class, so it is accessible from anywhere.
let DB_BASE = Database.database().reference()


//Singleton class, that is instatiated so it is available throughout the entire lifecycle of the app.
class DataService {
    //static means that when it is instatiated it is so for the entire lifecycle of the app.
    // the variable is equal to this class
    static let instance = DataService()
    
    //data incapsilation, with private
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_DRIVERS = DB_BASE.child("drivers")
    private var _REF_TRIPS = DB_BASE.child("trips")
    
    //preveting the variables above to be modifyed directly
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_DRIVERS: DatabaseReference {
        return _REF_DRIVERS
    }
    
    var REF_TRIPS: DatabaseReference {
        return _REF_TRIPS
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, Any>, isDriver: Bool) {
        if isDriver {
            REF_DRIVERS.child(uid).updateChildValues(userData)
        } else {
            REF_USERS.child(uid).updateChildValues(userData)
        }
    }
    
}
