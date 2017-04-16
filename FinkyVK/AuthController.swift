//
//  AuthController.swift
//  FinkyVK
//
//  Created by Alex Kostenko on 15.04.17.
//  Copyright © 2017 DoPPleR. All rights reserved.
//

import UIKit

class AuthController: UIViewController {

    @IBOutlet weak var authButton: UIButton!
    @IBOutlet weak var regButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authButton.layer.cornerRadius = 5
        authButton.layer.borderWidth = 1
        authButton.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func authButtonAction(_ sender: Any) {
        VKAPIManager.login()
    }
    
    @IBAction func regButtonAction(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string: "https://m.vk.com/join")! as URL)
    }

}
