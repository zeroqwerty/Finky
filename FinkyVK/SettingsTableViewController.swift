//
//  SettingsTableViewController.swift
//  FinkyVK
//
//  Created by Alex Kostenko on 17.04.17.
//  Copyright © 2017 DoPPleR. All rights reserved.
//

import UIKit
import Kingfisher

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var settingsProfileImage: UIImageView!
    @IBOutlet weak var settingsProfileName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if MenuController.user_photo != nil || MenuController.user_name != nil {
            settingsProfileImage.kf.setImage(with: URL(string: MenuController.user_photo!))
            settingsProfileImage.layer.cornerRadius = 40
            settingsProfileName.text = MenuController.user_name
        }
    
    }    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch (indexPath.section, indexPath.row) {
            case (2,0):
                VKAPIManager.logout()
                let next = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "AuthController") as! AuthController
                let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
                return (appDelegate.window?.rootViewController = next)!
            default: break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
