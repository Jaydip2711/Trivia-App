//
//  QuizViewModel.swift
//  Trivia App
//
//  Created by Jaydip on 09/01/20.
//  Copyright © 2020 Jaydip's Mackbook. All rights reserved.
//

import Foundation


class QuizViewModel: NSObject {
    
    var arrQueAns = [QueAnsModel]()
    var arrHistory = [History]()
    var fileName = "jsonRes"
    var userName = ""
    
    func getQuizData(complitionHandler:(_ success:Bool,_ message:String)-> Void) {
        
        if let path = Bundle.main.path(forResource: fileName, ofType: "txt") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let queAns = jsonResult["quiz"] as? [Any] {
                    debugPrint(queAns)
                    if let category = queAns as? [[String:Any]] {
                        var arrOption = [Answere]()
                        for objQuetion in category {
                            for objOption in objQuetion["options"] as? [[String:Any]] ?? []{
                                arrOption.append(Answere(objOption))
                            }
                            let objQue = QueAnsModel(objQuetion)
                            objQue.arrOption = arrOption
                            self.arrQueAns.append(objQue)
                            arrOption.removeAll()
                        }
                    }
                    complitionHandler(true,"success")
                }
            } catch let error {
                complitionHandler(false,"fail")
                print("show error: \(error.localizedDescription)")
            }
        } else {
            complitionHandler(false,"fail")
        }
    }
    
    func showResult(complitionHandler:(_ success:Bool,_ hisory:History)-> Void){
        var arrQuizQueAns = [QuizQueAns]()
        let _ = arrQueAns.map({ (objQue) -> Bool in
            let _ = objQue.arrOption.flatMap { (arrAnswere) -> [Answere] in
                arrQuizQueAns.append(QuizQueAns.init(strQuestion: objQue.strQue, arrAnswere: arrAnswere))
                return arrAnswere
            }
            return true
        })
        let objResult = History.init(userName: userName, strDate: Date().convertDateToStr(format: "dd MMM, yyyy HH:mm"), arrQuiz: arrQuizQueAns)
        
        //arrHistory.append(objResult)
        
        var arrHistorys = Utility.getHistory()
        if arrHistorys.count <= 0 {
            arrHistory.append(objResult)
            Utility.saveResults(arrHistory)
        } else {
            arrHistory.append(objResult)
            arrHistorys.append(objResult)
            Utility.saveResults(arrHistorys)
        }
        complitionHandler(true,objResult)
        
        complitionHandler(true,objResult)
        
    }
}

