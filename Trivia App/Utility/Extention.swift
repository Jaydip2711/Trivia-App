//
//  Extention.swift
//  Trivia App
//
//  Created by Jaydip on 09/01/20.
//  Copyright © 2020 Jaydip's Mackbook. All rights reserved.
//

import Foundation
import UIKit


//MARK: Date Extension
extension Date {
    
    func convertDateToStr( format : String) -> String {
        
        let df = DateFormatter()
        df.dateFormat = format
        let strDate = df.string(from: self)
        return strDate
    }
}

//MARK:- ViewController Extension
extension UIViewController {
    func showAlertView(_ message: String!, completionHandler: @escaping (_ value: Bool) -> Void){
        let alertController = UIAlertController(title: "Trivia App", message: message, preferredStyle: .alert)
        let btnOKAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            completionHandler(true)
        }
        alertController.addAction(btnOKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

//MARK:- String Extension
extension String {
    func trim() -> String{
        let strTrimmed = (NSString(string:self)).trimmingCharacters(in: CharacterSet.whitespaces)
        return strTrimmed
    }
}

