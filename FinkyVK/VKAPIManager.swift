//
//  VKAPIManager.swift
//  FinkyVK
//
//  Created by Alex Kostenko on 15.04.17.
//  Copyright © 2017 DoPPleR. All rights reserved.
//

import SwiftyVK
import UIKit

class VKAPIManager: VKDelegate {
    
    let appID = "5744830" // 5256902 VK LIVE
    let scope: Set<VK.Scope> = [.offline, .friends, .photos, .video, .status, .messages, .wall, .groups, .notifications, .email]
    
    init() {
        VK.config.apiVersion = "5.65"
        VK.config.language = "ru"
        VK.configure(withAppId: appID, delegate: self)
    }
    
    func vkWillAuthorize() -> Set<VK.Scope> {
        return scope
    }
    
    func vkDidAuthorizeWith(parameters: Dictionary<String, String>) {
        
        let next = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "isAuthorized") as! CustomSideMenuController
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        appDelegate.window?.rootViewController = next
        
        //NotificationCenter.default.post(name: Notification.Name(rawValue: "TestVkDidAuthorize"), object: nil)
    }
    
    func vkAutorizationFailedWith(error: AuthError) {
        print("Autorization failed with error: \n\(error)")
        //NotificationCenter.default.post(name: Notification.Name(rawValue: "TestVkDidNotAuthorize"), object: nil)
    }
    
    func vkDidUnauthorize() {}
    
    func vkShouldUseTokenPath() -> String? {
        return nil
    }
    
    func vkWillPresentView() -> UIViewController {
        return UIApplication.shared.delegate!.window!!.rootViewController!
    }
    
    class func logout() {
        VK.logOut()
    }
    
    class func login() {
        VK.logIn()
    }
    
    class func isAuthorized() -> Bool {
        return VK.state == .authorized
    }
    
    class func baseInfoGet() -> RequestExecution {
        
        let request = VK.API.remote(method: "getBaseInfo")
        let requestSend = request.send(
            onSuccess:  {
                response in
                VKJSONParser.parseBaseInfo(profile: response)
        },
            onError:  {
                error in
                print("ERROR IN baseInfoGet(): \(error.localizedDescription)")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: VKAPIBaseProfileInfoErrorLoad), object: nil)
        })
        
        return requestSend!
    }
    
    class func friendsGet() -> RequestExecution {
        
        let request = VK.API.Friends.get()
        let requestSend = request.send(
            onSuccess:  {
                response in
                VKJSONParser.parseFriends(friends: response)
            }, onError:  {
            error in
                
        })
        
        return requestSend!
    }
    
}

private typealias VKJSONParser = VKAPIManager
extension VKJSONParser {
    
    // Парсит ответ базовой информации о пользователе
    class func parseBaseInfo(profile: JSON) {
        MenuController.user_id = profile["id"].int
        MenuController.user_firstname = profile["first_name"].string!
        MenuController.user_lastname = profile["last_name"].string!
        MenuController.user_photo = profile["photo"].string
        MenuController.user_header = profile["thumb"].string
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: VKAPIBaseProfileInfoSuccessLoad), object: nil)
    }
    
    // Парсит ответ со список друзей
    class func parseFriends(friends: JSON) {
        
    }
}
