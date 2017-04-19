//
//  SettingsThemeTableViewController.swift
//  FinkyVK
//
//  Created by Alex Kostenko on 18.04.17.
//  Copyright © 2017 DoPPleR. All rights reserved.
//

import UIKit

class SettingsThemeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
            case (1,0):
                self.navigationController?.navigationBar.barTintColor = Styles.customColor1
                Styles.setNewColorNavBar(color: Styles.customColor1)
            case (1,1):
                self.navigationController?.navigationBar.barTintColor = Styles.customColor2
                Styles.setNewColorNavBar(color: Styles.customColor2)
            case (1,2):
                self.navigationController?.navigationBar.barTintColor = Styles.customColor3
                Styles.setNewColorNavBar(color: Styles.customColor3)
            case (1,3):
                self.navigationController?.navigationBar.barTintColor = Styles.customColor4
                Styles.setNewColorNavBar(color: Styles.customColor4)
            case (1,4):
                self.navigationController?.navigationBar.barTintColor = Styles.customColor5
                Styles.setNewColorNavBar(color: Styles.customColor5)
            default: break
        }
    }

}
