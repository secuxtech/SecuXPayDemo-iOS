//
//  Wallet.swift
//  SecuXTest
//
//  Created by Maochun Sun on 2019/11/7.
//  Copyright © 2019 Maochun Sun. All rights reserved.
//

import Foundation
import SecuXPaymentKit

struct PaymentHistoryInfo: Codable {
    var storeName: String
    var accountName: String
    var coinType: String
    var timestamp: String
    var amount: String
    var amountUSD: String
}

class Account : SecuXAccount {
    
    var usdBalance : Double = 0
    var formatedBalance = Observable<Double>(value: 0)
    
    

    public func getCoinImg() -> UIImage?{
        switch self.type {
        case .BTC:
            return UIImage(named: "btc")
            
            
        case .BCH:
            return UIImage(named: "bch")
            
            
        case .BNB:
            return UIImage(named: "bnb")
            
            
        case .DCT, .IFC:
            return UIImage(named: "dct")
            
            
        case .DGB:
            return UIImage(named: "dgb")
            
            
        case .DSH:
            return UIImage(named: "dsh")
            
            
        case .ETH:
            return UIImage(named: "eth")
            
            
        case .GRS:
            return UIImage(named: "grs")
            
            
        case .LBR:
            return UIImage(named: "lbr")
            
            
        case .LTC:
            return UIImage(named: "ltc")
            
            
        case .XRP:
            return UIImage(named: "xrp")
            
        }
        
    }
}


class Wallet: NSObject {
    
    private var accountArray = [Account]()
    var paymentHistory = [PaymentHistoryInfo]()
    
    private var accountMgr: SecuXAccountManager?
    private var coinToUSDRateDict: [CoinType:Double] = [:]
    private var coinToUSDRateDictLock = NSLock()
    private var updateCurrencyTimer: Timer!
    
    
    static let shared: Wallet = {
        let shared = Wallet()
        
        return shared
    }()
    
    public func getAccounts() -> [Account]{
        return accountArray
    }
    
    public func getAccount(type: CoinType) -> Account? {
        for account in self.accountArray{
            if account.type.rawValue == type.rawValue{
                return account
            }
        }
        return nil
    }
    
    public func getCoinToUSDRate(type: CoinType) -> Double? {
        self.coinToUSDRateDictLock.lock()
        let rate = self.coinToUSDRateDict[type]
        self.coinToUSDRateDictLock.unlock()
        
        return rate
    }
    
    func getAccountBalanceAsync(account: Account){
        DispatchQueue.global(qos: .default).async{
            
            let (ret, balance) = self.accountMgr!.getAccountBalance(account: account)
            if ret, let balance = balance{
                
                if self.coinToUSDRateDict.count == 0{
                    self.coinToUSDRateDictLock.lock()
                    self.coinToUSDRateDict = self.accountMgr!.getCoinUSDRate()
                    self.coinToUSDRateDictLock.unlock()
                }
                
                var usdBalance = balance.balance_usd
                if usdBalance == 0, balance.formattedBalance > 0, let rate = self.getCoinToUSDRate(type: account.type){
                    usdBalance = balance.formattedBalance * rate
                }
                
                print("Get account balance succssfully! \(balance.balance) USD Balance = \(usdBalance) Balance = \(balance.formattedBalance)")

                account.formatedBalance.value = balance.formattedBalance
                account.usdBalance = usdBalance
                
            }else{
                print("Get account balance failed!")
                
                
            }
            
            
            
        }
    }

    
    private override init(){
        super.init()
        logw("Wallet init")
        
        self.accountMgr = SecuXAccountManager()
        self.updateCurrencyTimer = Timer.scheduledTimer(timeInterval: 3*60, target: self, selector: #selector(updateCoinCurrencyAction), userInfo: nil, repeats: true)
        self.updateCurrencyTimer.fire()
        
        loadAccounts()
    }
    
    deinit {
        logw("Wallet deinit")
        self.updateCurrencyTimer.invalidate()
    }
    
    private func loadAccounts(){
        
        let decentAccount = Account(name: "ifun-886-936105934-6", type: .DCT, path: "", address: "", key: "")
        let ifcAccount = Account(name: "ifun-886-900-112233-44", type: .IFC, path: "", address: "", key: "")
        
        self.accountArray.append(decentAccount)
        self.accountArray.append(ifcAccount)
    }
  
    
    @objc func updateCoinCurrencyAction() {
        logw("updateCoinCurrencyAction")
        
        DispatchQueue.global(qos: .default).async {
            self.coinToUSDRateDictLock.lock()
            self.coinToUSDRateDict = self.accountMgr!.getCoinUSDRate()
            self.coinToUSDRateDictLock.unlock()
        }
        
    }
    
    
    
}
