//
//  OWMLocalStore.swift
//  OpenWeatherMap
//
//  Created by Mona Qora on 12/27/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import Foundation

class LocalStore: NSObject {

    static func storeDataLocally<DataModel:Codable>(key: String, dataModel: DataModel){
        if let data = try? JSONEncoder().encode(dataModel){
            let userDefaults: UserDefaults = UserDefaults.standard
            userDefaults.set(data, forKey: key)
        }
    }
    
    static func loadDataStored<DataModel:Codable>(key: String) -> DataModel? {
        let userDefaults: UserDefaults = UserDefaults.standard
        if let returnedData = userDefaults.object(forKey: key) as? Data {
            if let dataModel = try? JSONDecoder().decode(DataModel.self, from: returnedData) {
                return dataModel
            }
        }
        return nil
    }
    
    static func deleteStoredData(key: String) {
        let userDefaults: UserDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: key)
    }

}

