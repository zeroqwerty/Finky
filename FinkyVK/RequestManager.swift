//
//  RequestManager.swift
//  FinkyVK
//
//  Created by Alex Kostenko on 17.04.17.
//  Copyright © 2017 DoPPleR. All rights reserved.
//

import UIKit
import SwiftyVK

/// Отвечает за обработку запросов на загрузку данных с сервера VK
class RequestManager {

    static let sharedInstance: RequestManager = { RequestManager() }()
    
    private init() {
        activeRequests = [:]
        
        getBaseInfo = GetBaseInfo(defaultState: .NotSearchedYet, defaultError: .None, key: requestKeys.GetBaseInfo)
    }
    
    // MARK: -Работа с активными запросами
    
    /// Активные запросы
    var activeRequests: [String : RequestExecution]
    
    // Отмена запросов при деавторизации
    func userDidUnautorize() {
        getBaseInfo.cancel()
        getBaseInfo.dropState()
    }
    
    // Получение базовой информации о пользователе
    let getBaseInfo: RequestManagerObject
    
}

// MARK: Типы данных

private typealias _RequestManagerDataTypes = RequestManager
extension _RequestManagerDataTypes {
    
    /// Ключи для запросов
    struct requestKeys {
        
        /// Ключ на получение базовой информации о пользователе
        static let GetBaseInfo = "getBaseInfo"
        
    }
    
}
