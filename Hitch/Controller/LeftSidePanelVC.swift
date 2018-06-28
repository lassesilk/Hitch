//
//  LeftSidePanelVC.swift
//  Hitch
//
//  Created by Lasse Silkoset on 21.06.2018.
//  Copyright © 2018 Lasse Silkoset. All rights reserved.
//

import UIKit
import Firebase

class LeftSidePanelVC: UIViewController {
    
    let appDelegate = AppDelegate.getAppDelegate()
    
//    let currentUserId = Auth.auth().currentUser?.uid

    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userAccountTypeLabel: UILabel!
    @IBOutlet weak var userImageView: RoundImageView!
    @IBOutlet weak var loginOutButton: UIButton!
    @IBOutlet weak var pickupModeSwitch: UISwitch!
    @IBOutlet weak var pickupModeLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        pickupModeSwitch.isOn = false
        pickupModeSwitch.isHidden = true
        pickupModeLabel.isHidden = true
        
        observePassengersAndDrivers()
        
        if Auth.auth().currentUser == nil {
            userEmailLabel.text = ""
            userAccountTypeLabel.text =  ""
            userImageView.isHidden = true
            loginOutButton.setTitle("Sign up / Login", for: .normal)
        } else {
            userEmailLabel.text = Auth.auth().currentUser?.email
            userAccountTypeLabel.text = ""
            userImageView.isHidden = false
            loginOutButton.setTitle("Logout", for: .normal)
        }
    }
    
    func observePassengersAndDrivers() {
    
        DataService.instance.REF_USERS.observeSingleEvent(of: .value, with: { (snapshot) in
            //capturing all children of users node, and all objects beneath
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if snap.key == Auth.auth().currentUser?.uid {
                        self.userAccountTypeLabel.text = "PASSENGER"
                    }
                }
            }
        })
        DataService.instance.REF_DRIVERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if snap.key == Auth.auth().currentUser?.uid {
                        self.userAccountTypeLabel.text = "DRIVER"
                        self.pickupModeSwitch.isHidden = false
                        
                        let switchStatus = snap.childSnapshot(forPath: "isPickupModeEnabled").value as! Bool
                        self.pickupModeSwitch.isOn = switchStatus
                        self.pickupModeLabel.isHidden = false
                    }
                }
            }
        })
    }

   
    @IBAction func switchWasToggled(_ sender: Any) {
        if pickupModeSwitch.isOn {
            pickupModeLabel.text = "PICK UP MODE ENABLED"
            if let currentUserId = Auth.auth().currentUser?.uid {
            appDelegate.menuContainerVC.toogleLeftPanel()
            DataService.instance.REF_DRIVERS.child(currentUserId).updateChildValues(["isPickupModeEnabled" : true])
            //Have to implement func to updatevalue on driver when logging in, since login by default is pickupmodedisabled.
            }
        } else {
            pickupModeLabel.text = "PICK UP MODE DISABLED"
            if let currentUserId = Auth.auth().currentUser?.uid {
            appDelegate.menuContainerVC.toogleLeftPanel()
            DataService.instance.REF_DRIVERS.child(currentUserId).updateChildValues(["isPickupModeEnabled" : false])
            }
        }
    }
    
    @IBAction func signUpLoginButtonPressed(_ sender: Any) {
        if Auth.auth().currentUser == nil {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
        present(loginVC!, animated: true, completion: nil)
            
            } else {
            do {
                try Auth.auth().signOut()
                userEmailLabel.text = ""
                userAccountTypeLabel.text = ""
                userImageView.isHidden = true
                pickupModeLabel.text = ""
                pickupModeSwitch.isHidden = true
                loginOutButton.setTitle("Sign up / Login", for: .normal)
            } catch(let error) {
                print(error)
            }
        }
    }
    
   

}
