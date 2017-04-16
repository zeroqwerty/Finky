//
//  Styles.swift
//  Finky
//
//  Created by DoPPleR on 04.04.17.
//  Copyright © 2017 DoPPleR. All rights reserved.
//

import UIKit

class Styles {
    
    static var refreshControllerCircle = UIColor.white
    static var refreshControllerFill = UIColor.init(red: 38/255.0, green: 76/255.0, blue: 143/255.0, alpha: 1.0)
    
    // Navgation Bar
    static var navigationBarBackground = refreshControllerFill
    static var navigationBarTintColor = refreshControllerCircle
    
    static func lightStyle() {
        Styles.refreshControllerCircle = UIColor.white
        Styles.refreshControllerFill = UIColor.init(red: 38/255.0, green: 76/255.0, blue: 143/255.0, alpha: 1.0)
    }
    
    static func darkStyle() {
        Styles.refreshControllerCircle = UIColor.orange
        Styles.refreshControllerFill = UIColor.init(red: 38/255.0, green: 76/255.0, blue: 143/255.0, alpha: 1.0)
    }
}
