//
//  CustomSideMenuController.swift
//  FinkyVK
//
//  Created by Alex Kostenko on 15.04.17.
//  Copyright © 2017 DoPPleR. All rights reserved.
//

import SideMenuController

class CustomSideMenuController: SideMenuController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performSegue(withIdentifier: "showNews", sender: nil)
        performSegue(withIdentifier: "containSideMenu", sender: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        SideMenuController.preferences.drawing.menuButtonImage = UIImage(named: "menu")
        SideMenuController.preferences.drawing.sidePanelPosition = .overCenterPanelLeft
        SideMenuController.preferences.drawing.sidePanelWidth = UIScreen.main.bounds.size.width - 70
        SideMenuController.preferences.drawing.centerPanelShadow = true
        SideMenuController.preferences.animating.statusBarBehaviour = .fadeAnimation
        super.init(coder: aDecoder)
    }
}
