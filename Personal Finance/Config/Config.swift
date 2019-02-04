//
//  Config.swift
//  Personal Finance
//
//  Created by Alfredo Villagomez on 2/4/19.
//  Copyright © 2019 Alfredo Villagomez. All rights reserved.
//

import Foundation

struct Config {
    static func infoForKey(_ key: String) -> String? {
        return (Bundle.main.infoDictionary?[key] as? String)?.replacingOccurrences(of: "\\", with: "")
    }
}
