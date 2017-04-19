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
    
    @IBOutlet weak var offlineImage: UIImageView!
    @IBOutlet weak var themeImage: UIImageView!
    @IBOutlet weak var generalImage: UIImageView!
    @IBOutlet weak var notificationsImage: UIImageView!
    @IBOutlet weak var aboutImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Картинка настроек невидимости
        offlineImage.image = UIImage(named: "Offline_Mode")?.withRenderingMode(.alwaysTemplate)
        offlineImage.tintColor = UIColor(red: 25/255.0, green: 118/255.0, blue: 210/255.0, alpha: 1.0)
        
        // Картинка настроек темы
        themeImage.image = UIImage(named: "Theme")?.withRenderingMode(.alwaysTemplate)
        themeImage.tintColor = UIColor(red: 25/255.0, green: 118/255.0, blue: 210/255.0, alpha: 1.0)
        // Картинка основных настроек
        generalImage.image = UIImage(named: "Settings")?.withRenderingMode(.alwaysTemplate)
        generalImage.tintColor = UIColor(red: 25/255.0, green: 118/255.0, blue: 210/255.0, alpha: 1.0)
        // Картинка настроек уведомлений
        notificationsImage.image = UIImage(named: "Notifications")?.withRenderingMode(.alwaysTemplate)
        notificationsImage.tintColor = UIColor(red: 25/255.0, green: 118/255.0, blue: 210/255.0, alpha: 1.0)
        // Картинка "О приложении"
        aboutImage.image = UIImage(named: "About")?.withRenderingMode(.alwaysTemplate)
        aboutImage.tintColor = UIColor(red: 25/255.0, green: 118/255.0, blue: 210/255.0, alpha: 1.0)
        
        if MenuController.user_photo != nil || MenuController.user_firstname != nil || MenuController.user_lastname != nil {
            settingsProfileImage.kf.setImage(with: URL(string: MenuController.user_photo!))
            settingsProfileImage.layer.cornerRadius = 42.5
            settingsProfileName.text = MenuController.user_firstname! + " " + MenuController.user_lastname!
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
