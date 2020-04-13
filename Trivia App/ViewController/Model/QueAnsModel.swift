//
//  QueAnsModel.swift
//  Trivia App
//
//  Created by Jaydip's Mackbook on 08/01/20.
//  Copyright © 2020 Jaydip's Mackbook. All rights reserved.
//

import Foundation
import UIKit

class QueAnsModel: NSObject {
    
    var strQue          : String?
    var arrOption       : [Answere]?
    
    init(_ dict: [String: Any]) {
        strQue      = dict["question"] as? String ?? ""
        arrOption   = dict["options"] as? [Answere] ?? []
    }
}

class Answere: NSObject,Codable {
    var strAns          : String?
    var isAnsSelected   : Bool?
    
    init(_ dict: [String: Any]) {
        strAns          = dict["ans"] as? String ?? ""
        isAnsSelected   = dict["isSelected"] as? Bool ?? false
    }
}

//for saveData
struct History:Codable {
    var userName    : String?
    var strDate     : String?
    var arrQuiz     :[QuizQueAns]?
}
struct QuizQueAns: Codable {
    var strQuestion : String?
    var arrAnswere  : [Answere]?
}

