//
//  DynamicValue.swift
//  OpenWeatherMap
//
//  Created by Mona Qora on 12/30/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import Foundation

class DynamicValue<Model> {
    
    typealias CompletionHandler = ((Model) -> Void)
    
    var value : Model {
        didSet {
            self.notify()
        }
    }
    
    private var observers = [String: CompletionHandler]()
    
    init(_ value: Model) {
        self.value = value
    }
    
    public func addObserver(_ observer: NSObject, completionHandler: @escaping CompletionHandler) {
        observers[observer.description] = completionHandler
    }
    
    public func addAndNotify(observer: NSObject, completionHandler: @escaping CompletionHandler) {
        self.addObserver(observer, completionHandler: completionHandler)
        self.notify()
    }
    
    private func notify() {
        observers.forEach({ $0.value(value) })
    }
    
    deinit {
        observers.removeAll()
    }
}

