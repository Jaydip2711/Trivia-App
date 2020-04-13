//
//  Constant.swift
//  Trivia App
//
//  Created by Jaydip on 09/01/20.
//  Copyright © 2020 Jaydip's Mackbook. All rights reserved.
//

import Foundation
import UIKit


let SB_Main = UIStoryboard.init(name: "Main", bundle: nil)
let userDefaults =  UserDefaults.standard
let KEY_HISTORY = "savewHistory"

class Utility {

    class func saveResults(_ arrHistory: [History]){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let encoded = try? encoder.encode(arrHistory) {
            userDefaults.set(encoded, forKey: KEY_HISTORY)
        }
    }
    class func getHistory() -> [History] {
        var arrHistory = [History]()
        if let savedHistory = userDefaults.object(forKey: KEY_HISTORY) as? Data {
            let decoder = JSONDecoder()
            if let history = try? decoder.decode([History].self, from: savedHistory) {
                arrHistory = history
            }
        }
        return arrHistory
    }
}

