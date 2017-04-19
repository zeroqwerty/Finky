//
//  ProfileViewController.swift
//  FinkyVK
//
//  Created by Alex Kostenko on 18.04.17.
//  Copyright © 2017 DoPPleR. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // Подключение хедера
    @IBOutlet var headerView: UIView!
    @IBOutlet var profileView: UIView!
    @IBOutlet weak var headerImage: UIImageView!
    
    // Подключение панели в хедере с основной информацией о профиле
    @IBOutlet var profileViewPanel: UIView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileOnline: UILabel!
    @IBOutlet weak var profileVerif: UIImageView!
    @IBOutlet weak var profilePhoto: UIImageView!
    
    // Подключение панели с действиями
    @IBOutlet weak var profileActionsPanel: UIView!
    @IBOutlet weak var actionsLabel: UILabel!
    @IBOutlet weak var actionsButton: UIButton!
    
    // Таблица
    @IBOutlet var tableView: UITableView!
    // Коллекция
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Переменные, заполняемые при переходе на этот контроллер
    var myProfile = true
    var userId: Int?
    var firstName: String?
    var lastName: String?
    var verif: Bool?
    var online: String?
    var photo: String?
    var header: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(headerView.frame.height, 0, 0, 0)
        
        /// Регистрация ячеек
        var cellNib = UINib(nibName: TableViewCellIdentifiers.loadingCell, bundle: nil) // Ячейка "Загрузка"
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.loadingCell)
        
        cellNib = UINib(nibName: CollectionViewCellIdentifiers.profileCollectionViewCell, bundle: nil) // Ячейка для коллекции
        collectionView.register(cellNib, forCellWithReuseIdentifier: CollectionViewCellIdentifiers.profileCollectionViewCell)
        
        configureProfile(myProfile: myProfile, id: MenuController.user_id, firstName: MenuController.user_firstname, lastName: MenuController.user_lastname, verif: true, online: nil, photo: MenuController.user_photo, header: MenuController.user_header)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.alpha = 1
    }
    
    // MARK: -Заполнение основных полей профиля
    func configureProfile(myProfile: Bool, id: Int?, firstName: String?, lastName: String?, verif: Bool?, online: String?, photo: String?, header: String?) {
        
        if let id = id {
            let moreImage = UIImage(named: "more")
            print(id)
            let rightSearchBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(moreOptions))
            self.navigationItem.setRightBarButtonItems([rightSearchBarButtonItem], animated: true)
        }
        
        profilePhoto.layer.cornerRadius = 50
        
        if myProfile {
            
            title = firstName
            profileName.text = firstName! + " " + lastName!
            verif! ? (profileVerif.isHidden = false) : (profileVerif.isHidden = true)
            
            if let online = online {
                profileOnline.text = online
            } else {
                profileOnline.text = " "
            }
            
            profilePhoto.kf.setImage(with: URL(string: photo!))
            headerImage.kf.setImage(with: URL(string: header!))
            
            return
        }
        
        print("other profile")
    }
    
    func moreOptions() {
        print("more")
    }
    
}

// MARK: -TableView делегаты
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Высота каждой строки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    // Ячейка для строки с сообщением о загрузке
    func getCellForLoadingRowForIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.loadingCell, for: indexPath as IndexPath) as! LoadingTableViewCell
        cell.activityIndicator.startAnimating()
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getCellForLoadingRowForIndexPath(indexPath: indexPath as NSIndexPath)
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
        //cell.textLabel?.text = String(indexPath.row + 1)
        cell.configureCell(type: "friends", image: nil, text: "Друзья:", count: "0")
        return cell
    }
    
}

// MARK: -Растягивание и убирание хедера при скроллинге
extension ProfileViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerOffset: CGFloat = 250 - 30
        let offset = scrollView.contentOffset.y + headerView.bounds.height
        var headerTransform = CATransform3DIdentity
        
        if offset <= 0 {
            let headerScaleFactor:CGFloat = -(offset) / headerView.bounds.height
            let headerSizevariation = ((headerView.bounds.height * (1.0 + headerScaleFactor)) - headerView.bounds.height) / 2
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            
            self.navigationController?.navigationBar.isHidden = true
            
        } else if offset == 250 {
            // Фикс бага при скроллинге коллекции
        } else {
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-headerOffset, -offset), 0)
            let alignToNameLabel = -offset + profileViewPanel.frame.origin.y + headerView.frame.height + headerOffset
            self.navigationController?.navigationBar.alpha = min (1.0, (offset - alignToNameLabel) / 60)
            self.navigationController?.navigationBar.isHidden = false
        }
        headerView.layer.transform = headerTransform
    }
}
