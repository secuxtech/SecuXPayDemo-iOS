//
//  AccountListViewModel.swift
//  SecuXWallet
//
//  Created by Maochun Sun on 2019/11/11.
//  Copyright © 2019 Maochun Sun. All rights reserved.
//

import Foundation




class AccountListViewModel: RestRequestHandler {
    
    //let decentRestAPIsHandler = DecentifunportalRestfulHandler()
    
    //let balanceSvrUrl = "https://pmswb.secuxtech.com/Account/GetAccountBalance"
    //let historySvrUrl = "https://pmswb.secuxtech.com/Transaction/GetTxHistory"
    
    let secXSvrReqHandler = SecuXServerRequestHandler()
    
    func updateAllAccountBalance(){
        //self.updateHWAccountBalanceAsync()
        self.updateSWAccountBalanceAsync()
        
        
    }
    
    func updateSWAccountBalanceAsync(){
    
        /*
        for coin in Wallet.shared.swCoinArr{
            for acc in coin.accounts{
                
                DispatchQueue.global(qos: .default).async{
                    var _ = self.getAccountBalance(account: acc)
                }
            }
        }

        //Wallet.shared.saveSWAccount()
        */
    }
    
    
    
    
    func updateSWAccountBalance(){
    
        /*
        for coin in Wallet.shared.swCoinArr{
            for acc in coin.accounts{
                var _ = self.getAccountBalance(account: acc)
            }
        }

        //Wallet.shared.saveSWAccount()
        */
    }
    
    
    
    func getAccountBalance(account: Account) -> Bool{
        
        
        
        return false
    }
    
    func getAccountHistory(account: Account) -> Bool{
        
        
        
        return false
    }
    
    /*
     https://pmsapi.secuxtech.com/Transaction/GetTxHistory?coinType=DCT&pubKey=dw-jat1168
     
     https://pmsapi.secuxtech.com/Account/GetAccountBalance?coinType=DCT&pubKey=dw-jat1168
     
    */
    
    private func getDCTAccountBalance(account: Account) -> Bool{
        logw("getDCTAccountBalance \(account.name)")
        
        
        return false
    }
    
    private func getDCTAccountHistory(account: Account) -> Bool{
        
        return false
    }
    
    private func getLBRAccountBalance(account: Account) -> Bool{
        
        return false
    }
    
    private func getLBRAccountHistory(account: Account) -> Bool{
        
        return false
    }
    
    
    private func getBTCAccountBalance(account: Account) -> Bool{
        logw("getBTCAccountBalance \(account.name)")
        
        
        
        
        return false
    }
    
    private func getBTCAccountBalanceByAddr(account: Account) -> Bool{
        logw("getBTCAccountBalanceByAddr \(account.name)")
        
        
        
        
        
        return false
    }
    
    private func getBTCAccountHistory(account: Account) -> Bool{
        
        logw("getBTCAccountHistory \(account.name)")
        
        
    
        
        return false

    }
    
    private func getBTCAccountHistoryByAddr(account: Account) -> Bool{
        logw("getBTCAccountHistoryByAddr \(account.name)")
        
       
    

        return false
    }
    
    
    /*
    func getDCTAccountBalance(account: Account){
        if account.name.count == 0{
        
           return
        }

        let reqURL = "https://pmsapi.secuxtech.com/Account/GetAccountBalance"
        let param = ["coinType": "DCT", "pubKey":"\(account.name)"]
        let (ret, data) = self.postRequestSync(urlstr: reqURL, param: param)
        if ret, let accInfo = data{
        
            self.handleAccountBalanceData(account: account, accInfo: accInfo)
            
        }else{
            print("getDCTAccountBalance \(account.name) failed")
        }
        
    }
    
    func getDCTAccountHistory(account: Account){
        if account.name.count == 0{
           return
        }

        let reqURL = "https://pmsapi.secuxtech.com/Transaction/GetTxHistory"
        let param = ["coinType": "DCT", "pubKey":"\(account.name)"]
        let (ret, data) = self.postRequestSync(urlstr: reqURL, param: param)
        if ret, let accInfo = data{
        
            self.handleAccountHistoryData(account: account, accInfo: accInfo)
        }else{
            print("getDCTAccountHistory \(account.name) failed")
        }
        
    }
    */
    /*
     https://pmsapi.secuxtech.com/Account/GetAccountBalance?coinType=BTC&pubKey=xpub6CUGRUonZSQ4TWtTMmzXdrXDtypWKiKrhko4egpiMZbpiaQL2jkwSB1icqYh2cfDfVxdx4df189oLKnC5fSwqPfgyP3hooxujYzAu3fDVmz
     
     
     {
         "balance": 491868,
         "formattedBalance": 0.00491868,
         "balance_usd": 34.1115868548
     }
     
    */
    
    /*
    func getBTCAccountBalance(account: Account){
        print("getAccountBalance")
        
        
        
        for _ in 0 ... 3{
            if account.theKey.count == 0{
                //account.theAddress = JSManager.manager.getAddress(path: account.thePath, coinSymbol: account.type.rawValue)
                
                account.theKey = JSManager.manager.getPublicKey(path: account.thePath)
            }
            
            if account.theKey.count > 0{
                break
            }else{
                sleep(1)
            }
        }
        
        if account.theKey.count == 0{
            print("No account key get account balance abort!!!")
            return
        }
        
        let reqURL = "https://pmsweb.secuxtech.com/Account/GetAccountBalance"
        let param = ["coinType": "\(account.type.rawValue)", "pubKey":"\(account.theKey)"]
        let (ret, data) = self.postRequestSync(urlstr: reqURL, param: param)
        
        if ret, let accInfo = data{
            do{
                let json  = try JSONSerialization.jsonObject(with: accInfo, options: []) as! [String : Any]
                print(json)
                
                if let bal = json["formattedBalance"] as? Double{
                    account.balance = String(bal)
                }
                
                if let balUSD = json["balance_usd"] as? Double{
                    account.theUSDBalance.value = balUSD.roundToDecimal(2)
                    
                }
                
                print("getAccountBalance \(account.name) \(account.balance) \(account.theUSDBalance.value)")
                
            }catch{
                print("getAccountBalance error: " + error.localizedDescription)
            }
        }else{
            print("getBTCAccountBalance \(account.name) failed")
        }
        
        
    }
    */
    
    /*
     https://pmsapi.secuxtech.com/Transaction/GetTxHistory?coinType=BTC&pubKey=xpub6CUGRUonZSQ4TWtTMmzXdrXDtypWKiKrhko4egpiMZbpiaQL2jkwSB1icqYh2cfDfVxdx4df189oLKnC5fSwqPfgyP3hooxujYzAu3fDVmz
     
     
     [
     {
         "address": "1LDPJCMZhYZjTvTGYahdhMXLuMfjfi6Kua",
         "tx_type": "Receive",
         "amount": 1000,
         "formatted_amount": 0.00001,
         "amount_usd": 0.0868179,
         "timestamp": "2019-09-25 16:12:10",
         "detailsUrl": "https://blockchair.com/bitcoin/transaction/a24445474a9a7c0698e8db221ad2cae06792a899e9bc7f5a590687c3c810c480"
     },
     {
         "address": "1MS6eGqD4iUGyJPbEsjqmoNaRhApgtmF8J",
         "tx_type": "Receive",
         "amount": 1800,
         "formatted_amount": 0.000018,
         "amount_usd": 0.115704,
         "timestamp": "2018-11-07 17:26:45",
         "detailsUrl": "https://blockchair.com/bitcoin/transaction/0c9a0219a8f3ef4a7d00483a755a9a18a674340c547bdf573481c1c613898746"
     },
     
     ...]
    */
    
    /*
    func getBTCAccountHistory(account: Account){
        
        for _ in 0 ... 3{
            if account.theKey.count == 0{
                //account.theAddress = JSManager.manager.getAddress(path: account.thePath, coinSymbol: account.type.rawValue)
                
                account.theKey = JSManager.manager.getPublicKey(path: account.thePath)
                
            }
            
            if account.theKey.count > 0{
                break
            }else{
                sleep(1)
            }
        }
    
        if account.theKey.count == 0{
            print("No account key get account history abort!!!")
            return
        }
        
        //let reqURL = "https://pmsapi.secuxtech.com/Transaction/GetTxHistory"
        let reqURL = "https://pmsweb.secuxtech.com/Transaction/GetTxHistory"
        let param = ["coinType": "\(account.type.rawValue)", "pubKey":"\(account.theKey)"]
        let (ret, data) = self.postRequestSync(urlstr: reqURL, param: param)
        
        if ret, let accInfo = data{
            
            let decoder = JSONDecoder()
            
            do {
                let accHistory = try decoder.decode([AccountHistory].self, from: accInfo)
                
                account.accHistory = accHistory
                
                
            } catch let e {
                print(e)
            }
        }else{
            print("getBTCAccountHistory \(account.name) failed")
        }
        
        account.updateAccHistory.value = true
    }
    */
    
    private func handleAccountBalanceData(account: Account, accInfo: Data) -> Bool{
        
        
        
        return false
    }
    
    private func handleAccountHistoryData(account: Account, accInfo: Data) -> Bool{
        
        
        return false
    }
}
