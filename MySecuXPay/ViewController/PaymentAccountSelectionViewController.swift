//
//  PaymentAccountSelectionViewController.swift
//  SecuXWallet
//
//  Created by Maochun Sun on 2019/12/24.
//  Copyright © 2019 Maochun Sun. All rights reserved.
//

import UIKit
import SecuXPaymentKit

class PaymentAccountSelectionViewController: UIViewController {

    var theAccounts = [Account]()
    var selAccount : Account?
    var selAccType : CoinType?
    var showDCTAcc = true
    
    lazy var theTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x:0, y:0, width: 0, height: 0), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //tableView.estimatedRowHeight = 70
        tableView.rowHeight = 90
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.backgroundColor = UISetting.shared.portfolioBKColor
        
        self.view.addSubview(tableView)
        

        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -5)
        
        ])
        
        tableView.register(AccountTableViewCell.self, forCellReuseIdentifier: AccountTableViewCell.cellIdentifier())
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UISetting.shared.portfolioBKColor
        self.showDCTAcc = true
        
        self.theAccounts = Wallet.shared.getAccounts()
        for account in self.theAccounts{
            Wallet.shared.getAccountBalanceAsync(account: account)
        }
        
        self.theTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        var count = self.theAccounts.count
        while count > 0{
            if let cell = self.theTableView.cellForRow(at: IndexPath(row: self.theAccounts.count-count, section: 0)) as? AccountTableViewCell{
                cell.removeAccountBalanceObserver()
            }
            
            count -= 1
        }
        
    }
    


}


extension PaymentAccountSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.theAccounts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountTableViewCell.cellIdentifier(), for:indexPath)
        cell.selectionStyle = .none
        if let commonCell = cell as? AccountTableViewCell{
            
            commonCell.setup(account: theAccounts[indexPath.row])
        }
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        tableView.cellForRow(at: indexPath)?.accessoryView = UIImageView(image: UIImage(named: "list_icon_check"))
        
        
        
        self.selAccount = self.theAccounts[indexPath.row]
        if let type = self.selAccount?.type{
            self.selAccType = type
        }
        
        

        self.dismiss(animated: true, completion: nil)
        self.popoverPresentationController?.delegate?.popoverPresentationControllerDidDismissPopover?(popoverPresentationController!)
    }
        
    /*
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        
        if let currSel = self.selAccount{

            var idx = 0
            for item in self.theAccounts{
                if item.name == currSel.name{
                    break
                }
                
                idx += 1
            }
            
            tableView.cellForRow(at: IndexPath(row: idx, section: 0))?.accessoryType = .none
            //tableView.cellForRow(at: IndexPath(row: idx, section: 0))?.accessoryView = nil
        }
        return indexPath
    }
    */
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
       
        
        return 70
    }
}
