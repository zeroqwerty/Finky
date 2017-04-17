//
//  RequestManagerObject.swift
//  FinkyVK
//
//  Created by Alex Kostenko on 17.04.17.
//  Copyright © 2017 DoPPleR. All rights reserved.
//

import UIKit

/// Запрос на сервер
class RequestManagerObject {
    
    /// Ключ запроса
    internal(set) var key: String
    
    // Состояние при инициализации
    
    /// Статус по умолчанию
    private let defaultState: State
    /// Ошибка по умолчанию
    private let defaultError: ErrorRequest
    
    
    // Текущее состояние
    
    /// Статус выполнения
    internal(set) var state: State
    /// Ошибка при выполнении
    internal(set) var error: ErrorRequest
    
    
    init(defaultState: State, defaultError: ErrorRequest, key: String) {
        self.key = key
        
        self.defaultState = defaultState
        state = self.defaultState
        
        self.defaultError = defaultError
        error = self.defaultError
    }
    
    deinit {
        removeObservers()
    }
    
    /// Выполнение запроса без аргументов
    func performRequest(completion: @escaping (Bool) -> Void) {
        performRequest(parameters: [:], withCompletionHandler: completion)
    }
    
    /// Выполнение запроса с аргументами
    func performRequest(parameters: [Argument : AnyObject], withCompletionHandler completion: @escaping (Bool) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    /// Отменяет выполенение запроса
    func cancel() {
        if let activeRequest = RequestManager.sharedInstance.activeRequests[key] {
            activeRequest.cancel() // Отменяем выполнение запроса
            removeFromActiveRequests() // Удаляем запрос из списка активных
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            dropState() // Сбрасываем до состояние при инициализации
        }
    }
    
    /// Удаление состояние выполнения запроса
    func removeActivState() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        removeObservers() // Удаляем слушателей для оповещений о состоянии выполнения запроса
        removeFromActiveRequests() // Удаляем из списка активных запросов
    }
    
    /// Удаляет слушателей для текущего запроса
    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// Удаление запроса из списка активных
    func removeFromActiveRequests() {
        RequestManager.sharedInstance.activeRequests[key] = nil
    }
    
    /// Сбрасывание состояния запроса до состояния инициализации
    func dropState() {
        state = defaultState
        error = defaultError
        
        removeObservers()
    }
    
}


// MARK: Типы данных

private typealias _RequestManagerObjectDataTypes = RequestManagerObject
extension _RequestManagerObjectDataTypes {
    
    /// Состояния выполнения запросов
    enum State {
        
        /// Поиск еще не был выполен (или была ошибка)
        case NotSearchedYet
        /// Результат загружается
        case Loading
        /// Ничего не найдено
        case NoResults
        /// Результат поиска
        case Results
        
    }
    
    /// Ошибки при запросах
    enum ErrorRequest {
        
        /// Нет ошибок
        case None
        /// Проблемы при подключении к интернету
        case NetworkError
        /// Проблемы с доступом
        case AccessError
        /// Неизвестная ошибка
        case UnknownError
        
    }
    
    /// Ключи аргументов запросов
    enum Argument {
        
        /// Поисковый запрос
        case RequestText
        /// Идентификатор альбома
        case AlbumID
        /// Идентификатор пользователя
        case OwnerID
        
    }
    
}
