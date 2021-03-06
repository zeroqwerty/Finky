//
//  MenuController.swift
//  FinkyVK
//
//  Created by Alex Kostenko on 15.04.17.
//  Copyright © 2017 DoPPleR. All rights reserved.
//

import UIKit
import Kingfisher

class MenuController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    private var lastSelected: NSIndexPath?
    private var menuItems: [MenuItems] = [MenuItems(name: "Новости",     image: "News",        segue: "showNews"),
                                          MenuItems(name: "Ответы",      image: "Feedback",    segue: "showFeedback"),
                                          MenuItems(name: "Сообщения",   image: "Messages",    segue: "showMessages"),
                                          MenuItems(name: "Друзья",      image: "Friends",     segue: "showFriends"),
                                          MenuItems(name: "Группы",      image: "Communities", segue: "showCommunities"),
                                          MenuItems(name: "Фотографии",  image: "Photos",      segue: "showPhotos"),
                                          MenuItems(name: "Видеозаписи", image: "Videos",      segue: "showVideos"),
                                          MenuItems(name: "Аудиозаписи", image: "Audios",      segue: "showAudios"),
                                          MenuItems(name: "Закладки",    image: "Favorites",   segue: "showFavorites"),
                                          MenuItems(name: "Настройки",   image: "Settings",    segue: "showSettings")]
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerViewPanel: UIView!
    @IBOutlet weak var headerTouchZone: UIView!
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var headerPhoto: UIImageView!
    @IBOutlet weak var headerName: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    static var user_id: Int?
    static var user_firstname: String?
    static var user_lastname: String?
    static var user_photo: String?
    static var user_header: String?
    static var user_verif: Bool?
    
    // Статус выполнения запроса
    var requestManagerStatus: RequestManagerObject.State {
        return RequestManager.sharedInstance.getBaseInfo.state
    }
    
    // Ошибки, которые могут возникнуть при выполнении запроса
    var requestManagerError: RequestManagerObject.ErrorRequest {
        return RequestManager.sharedInstance.getBaseInfo.error
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestLoadBaseInfo()
        
        lastSelected = NSIndexPath(row: 0, section: 0)
        tableView.selectRow(at: lastSelected! as IndexPath, animated: true, scrollPosition: UITableViewScrollPosition(rawValue: 0)!)
    }
    
    func requestLoadBaseInfo() {
        RequestManager.sharedInstance.getBaseInfo.performRequest() { success in
            self.setBaseInfo()
        }
    }
    
    func setBaseInfo() {
        if MenuController.user_id != nil || MenuController.user_firstname != nil || MenuController.user_lastname != nil || MenuController.user_photo != nil {
            
            if MenuController.user_header != nil {
                headerImage.kf.setImage(with: URL(string: MenuController.user_header!))
            } else {
                headerImage.image = UIImage(named: "ava-h")
            }
            
            headerPhoto.kf.setImage(with: URL(string: MenuController.user_photo!))
            headerPhoto.layer.cornerRadius = 20
            headerName.text = MenuController.user_firstname! + " " + MenuController.user_lastname!
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.openProfile))
            headerTouchZone.addGestureRecognizer(tap)
        } else {
            headerImage.image = UIImage(named: "ava-h")
            headerPhoto.image = UIImage(named: "ava-h")
            headerPhoto.layer.cornerRadius = 20
            headerName.text = "Профиль"
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(requestLoadBaseInfo))
            headerTouchZone.addGestureRecognizer(tap)
        }
    }
    
    func openProfile() {
        if let index = lastSelected {
            tableView.deselectRow(at: index as IndexPath, animated: true)
        }
        
        sideMenuController?.performSegue(withIdentifier: "showProfile", sender: nil)
    }
    
    // Растягивание обложки про скролле вниз
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        headerViewPanel.frame.origin.y = 150 + -offset
        var headerTransform = CATransform3DIdentity
        if offset <= 0 {
            let headerScaleFactor:CGFloat = -(offset) / headerView.bounds.height
            let headerSizevariation = ((headerView.bounds.height * (1.0 + headerScaleFactor)) - headerView.bounds.height)/2
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
        } else {
            headerViewPanel.frame.origin.y = 150
        }
        headerView.layer.transform = headerTransform
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.cellImage.image = UIImage(named: menuItems[indexPath.row].image)
        cell.cellLabel.text = menuItems[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lastSelected = indexPath as NSIndexPath?
        sideMenuController?.performSegue(withIdentifier: menuItems[indexPath.row].segue, sender: nil)
    }
    
}
