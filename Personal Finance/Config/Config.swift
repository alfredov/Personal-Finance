//
//  Config.swift
//  Personal Finance
//
//  Created by Alfredo Villagomez on 2/4/19.
//  Copyright © 2019 Alfredo Villagomez. All rights reserved.
//

import Foundation

enum Keys: String {
    case TwitterConsumerKey
    case TwitterConsumerSecret
}

struct Config {
    fileprivate(set) lazy var TwitterConsumerkey: String? = {
        return infoForKey(Keys.TwitterConsumerKey.rawValue)
    }()
    
    fileprivate(set) lazy var TwitterConsumerSecret: String? = {
       return infoForKey(Keys.TwitterConsumerSecret.rawValue)
    }()
    
    private func infoForKey(_ key: String) -> String? {
        return (Bundle.main.infoDictionary?[key] as? String)?.replacingOccurrences(of: "\\", with: "")
    }
}
