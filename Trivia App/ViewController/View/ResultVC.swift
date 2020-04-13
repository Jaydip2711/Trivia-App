//
//  ResultVC.swift
//  Trivia App
//
//  Created by Jaydip on 09/01/20.
//  Copyright © 2020 Jaydip's Mackbook. All rights reserved.
//

import UIKit

class ResultVC: UIViewController {
    
    //MARK:- Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    //MARK:- Variable
    var viewModel : QuizViewModel?
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Result"
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(btnAddTapped))
        initData()
        
    }
    
    //MARK:- Other Function
    func initData(){
        
        viewModel?.showResult(complitionHandler: { (isSuccess, objResult) in
            if isSuccess {
                lblDate.text = objResult.strDate
                lblName.text = objResult.userName
                
                tableView.reloadData()
            }
        })
    }
    
    //MARK:- Action
    @IBAction func btnAddTapped(_ sender: UIButton){
        self.navigationController?.popToRootViewController(animated: true)
    }
}

//MARK:- Tablview Delegate
extension ResultVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel?.arrHistory.count ?? 0 > 0 {
            return viewModel?.arrHistory.first?.arrQuiz?.count ?? 0
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let obj = viewModel?.arrHistory.first?.arrQuiz?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTCell") as! ResultTCell
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
}

//MARK:- Cell Class File
class ResultTCell: UITableViewCell {
    
    @IBOutlet weak var lblQue: UILabel!
    @IBOutlet weak var lblAns: UILabel!
    
    override func awakeFromNib() {
        
    }
}
