
import UIKit

class SecondQueVC: UIViewController {
    
    //MARK:- Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblQuestion: UILabel!
    
    //MARK:- Variable
    var viewModel : QuizViewModel?
    var isAnsSelect = false
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Game"
        navigationItem.hidesBackButton = true
        
        lblQuestion.text = viewModel?.arrQueAns[1].strQue
    }
    
    //MARK:- Action
    @IBAction func btnNextTapped(_ sender: UIButton){
        
        if isAnsSelect{
            let resultVC = SB_Main.instantiateViewController(identifier: "ResultVC") as! ResultVC
            resultVC.viewModel = viewModel
            self.navigationController?.pushViewController(resultVC, animated: true)
        } else {
            self.showAlertView("please select correct options") { (_) in
                
            }
        }
    }
}

//MARK:- Tablview Delegate
extension SecondQueVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.arrQueAns[1].arrOption?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let obj = (viewModel?.arrQueAns[1].arrOption)?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondQueTCell") as! SecondQueTCell
        cell.lblAns.text = obj?.strAns
        cell.btnAns.isSelected = obj?.isAnsSelected ?? false  ? true : false
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = (viewModel?.arrQueAns[1].arrOption)?[indexPath.row]
        obj?.isAnsSelected = !(obj?.isAnsSelected ?? true)
        isAnsSelect = obj?.isAnsSelected ?? false
        tableView.reloadData()
    }
}

//MARK:- Cell Class File
class SecondQueTCell: UITableViewCell {
    
    @IBOutlet weak var btnAns: UIButton!
    @IBOutlet weak var lblAns: UILabel!
    
    override func awakeFromNib() {
        
    }
}
