//
//  FirstQueVC.swift
//  Trivia App
//
//  Created by Jaydip's Mackbook on 08/01/20.
//  Copyright © 2020 Jaydip's Mackbook. All rights reserved.
//

import UIKit



class FirstQueVC: UIViewController {
    
    //MARK:- Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblQuestion: UILabel!
    
    //MARK:- Variable
    var viewModel = QuizViewModel()
    var isAnsSelect = false
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Game"
        navigationItem.hidesBackButton = true
        
        viewModel.getQuizData { (isSuceess, message) in
            if isSuceess{
                lblQuestion.text = viewModel.arrQueAns[1].strQue
                self.tableView.reloadData()
            }else{
                self.showAlertView("No Quiz found") { (isOk) in }
            }
        }
    }
    
    //MARK:- Action
    @IBAction func btnNextTapped(_ sender: UIButton){
        if isAnsSelect {
            let secondQueVC = SB_Main.instantiateViewController(identifier: "SecondQueVC") as! SecondQueVC
            secondQueVC.viewModel = viewModel
            self.navigationController?.pushViewController(secondQueVC, animated: true)
        } else {
            self.showAlertView("Please select correct option") { (_) in
                
            }
        }
    }
}

//MARK:- Tablview Delegate
extension FirstQueVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.arrQueAns.count > 0 {
            return viewModel.arrQueAns[1].arrOption?.count ?? 0
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let obj = (viewModel.arrQueAns[0].arrOption)?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstQueTCell") as! FirstQueTCell
        cell.lblAns.text = obj?.strAns
        cell.btnAns.tag = indexPath.row
        cell.btnAns.isSelected = obj?.isAnsSelected ?? false  ? true : false
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = (viewModel.arrQueAns[0].arrOption)?[indexPath.row]
        obj?.isAnsSelected = true
        isAnsSelect = obj?.isAnsSelected ?? false
        let arrOption = viewModel.arrQueAns[0].arrOption
        for index in 0..<arrOption!.count {
            if index != indexPath.row {
                arrOption?[index].isAnsSelected = false
            }
        }
        tableView.reloadData()
    }
}

//MARK:- Cell Class File
class FirstQueTCell: UITableViewCell {
    
    @IBOutlet weak var btnAns: UIButton!
    @IBOutlet weak var lblAns: UILabel!
    
    override func awakeFromNib() {
        
    }
}
