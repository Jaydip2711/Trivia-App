//
//  HistoryVC.swift
//  Trivia App
//
//  Created by Jaydip on 09/01/20.
//  Copyright © 2020 Jaydip's Mackbook. All rights reserved.
//

import UIKit

class HistoryVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrHistory = [History]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "History"
        
        arrHistory =  Utility.getHistory()
        tableView.reloadData()
    }
}


//MARK:- Tablview Delegate
extension HistoryVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrHistory.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrHistory[section].arrQuiz?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let obj = arrHistory[indexPath.section].arrQuiz?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTCell") as! HistoryTCell
        
        cell.lblQue.text = "Question: " + (obj?.strQuestion ?? "")
        var arrAns = [String]()
        let _ = obj?.arrAnswere?.map({ (answere) -> [String] in
            if answere.isAnsSelected ?? false {
                arrAns.append(answere.strAns ?? "")
            }
            return arrAns
        })
        cell.lblAns.text = "Answere:  " +  arrAns.joined(separator: ", ")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTCell") as! HeaderTCell
        let obj = arrHistory[section]
        cell.lblGameName.text = "Game \(section + 1)"
        cell.lblDate.text = obj.strDate
        cell.lblName.text = obj.userName
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 106.0
    }
}

class HistoryTCell: UITableViewCell {
    
    @IBOutlet weak var lblQue: UILabel!
    @IBOutlet weak var lblAns: UILabel!
    
    override func awakeFromNib() {
        
    }
}
class HeaderTCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var lblGameName: UILabel!
    
    override func awakeFromNib() {
        
    }
}
