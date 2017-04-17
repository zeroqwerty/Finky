//
//  GetBaseInfo.swift
//  FinkyVK
//
//  Created by Alex Kostenko on 17.04.17.
//  Copyright © 2017 DoPPleR. All rights reserved.
//

import UIKit

class GetBaseInfo: RequestManagerObject {
    
    override func performRequest(parameters: [RequestManagerObject.Argument : AnyObject], withCompletionHandler completion: @escaping (Bool) -> Void) {
        super.performRequest(parameters: parameters, withCompletionHandler: completion)
        
        // Отмена выполнения предыдущего запроса и удаление загруженной информации
        cancel()
        
        // Если нет подключения к интернету
        if !Reachability.isConnectedToNetwork() {
            state = .NotSearchedYet
            error = .NetworkError
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            completion(false)
            
            return
        }
        
        // Слушатель для уведомления об успешном завершении получения друзей
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: BaseProfileInfoSuccessLoad), object: nil, queue: OperationQueue.main) { notification in
            self.removeActivState() // Удаление состояние выполнения запроса
            // Сохранение данных
            self.state = .Results
            self.error = .None
            
            completion(true)
        }
        
        // Слушатель для получения уведомления об ошибке при подключении к интернету
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: BaseProfileInfoErrorLoad), object: nil, queue: OperationQueue.main) { _ in
            self.removeActivState() // Удаление состояние выполнения запроса
            
            // Сохранение данных
            self.state = .NotSearchedYet
            self.error = .NetworkError
            
            completion(false)
        }
        
        // Слушатель для уведомления о других ошибках
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: BaseProfileInfoErrorLoad), object: nil, queue: OperationQueue.main) { _ in
            self.removeActivState() // Удаление состояние выполнения запроса
            
            // Сохранение данных
            self.state = .NotSearchedYet
            self.error = .UnknownError
            
            completion(false)
        }
        
        
        let request = VKAPIManager.baseInfoGet()
        
        state = .Loading
        error = .None
        
        RequestManager.sharedInstance.activeRequests[key] = request
    }
    
}
