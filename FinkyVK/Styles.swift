//
//  Styles.swift
//  Finky
//
//  Created by DoPPleR on 04.04.17.
//  Copyright © 2017 DoPPleR. All rights reserved.
//

import UIKit

class Styles {
    
    static var refreshControllerCircle          = UIColor.white
    static var refreshControllerFill            = UIColor.init(red: 38/255.0, green: 76/255.0, blue: 143/255.0, alpha: 1.0)
    
    // Navgation Bar
    static var navigationBarBackground          = refreshControllerFill
    static var navigationBarTintColor           = refreshControllerCircle
    
    // Настройки -> иконки
    static var SettingsImageTintColor           = UIColor.init(red: 38/255, green: 76/255, blue: 143/255, alpha: 1.0)
    
    /// Цвета дневной темы
    static var customColor1                     = UIColor.init(red: 38/255, green: 76/255, blue: 143/255, alpha: 1.0) // синий
    static var customColor2                     = UIColor.init(red: 213/255, green: 86/255, blue: 86/255, alpha: 1.0) // красный
    static var customColor3                     = UIColor.init(red: 153/255, green: 87/255, blue: 188/255, alpha: 1.0) // Фиолетовый
    static var customColor4                     = UIColor.init(red: 44/255, green: 160/255, blue: 130/255, alpha: 1.0) // Зеленый
    static var customColor5                     = UIColor.init(red: 45/255, green: 60/255, blue: 81/255, alpha: 1.0) // Темно-серый
    
    static func lightStyle() {
        Styles.refreshControllerCircle          = UIColor.white
        Styles.refreshControllerFill            = UIColor.init(red: 38/255.0, green: 76/255.0, blue: 143/255.0, alpha: 1.0)
    }
    
    static func darkStyle() {
        Styles.refreshControllerCircle          = UIColor.orange
        Styles.refreshControllerFill            = UIColor.init(red: 38/255.0, green: 76/255.0, blue: 143/255.0, alpha: 1.0)
    }
    
    class func setNewColorNavBar(color: UIColor) {
        UINavigationBar.appearance().barTintColor = color
    }
}
