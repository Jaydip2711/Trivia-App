//
//  ViewController.swift
//  Trivia App
//
//  Created by Jaydip's Mackbook on 08/01/20.
//  Copyright © 2020 Jaydip's Mackbook. All rights reserved.
//

import UIKit



class NameVC: UIViewController {
    
    //MARK:- Outlet
    @IBOutlet weak var txtName : UITextField!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trivia"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show History", style: .plain, target: self, action: #selector(btnHistoryTapped))
        txtName.layer.borderColor = UIColor.lightGray.cgColor
        txtName.layer.borderWidth = 1.0
        txtName.layer.cornerRadius = 5.0
        txtName.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 5, height: 5))
        txtName.leftViewMode = .always
    }
    
    //MARK:- Action
    @IBAction func btnNextTapped(_ sender: UIButton){
        view.endEditing(true)
        if txtName.text?.trim().isEmpty ?? false {
            self.showAlertView("Please enter your name") { (isOk) in }
        } else {
            let firstQueVC = SB_Main.instantiateViewController(identifier: "FirstQueVC") as! FirstQueVC
            firstQueVC.viewModel.userName = txtName.text ?? ""
            txtName.text = ""
            self.navigationController?.pushViewController(firstQueVC, animated: true)
        }
    }
    @IBAction func btnHistoryTapped(_ sender: UIButton){
        let historyVC = SB_Main.instantiateViewController(identifier: "HistoryVC") as! HistoryVC
        self.navigationController?.pushViewController(historyVC, animated: true)
    }
}
