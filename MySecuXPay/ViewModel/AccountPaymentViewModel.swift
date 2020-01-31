//
//  AccountPayViewModel.swift
//  SecuXWallet
//
//  Created by Maochun Sun on 2019/11/11.
//  Copyright © 2019 Maochun Sun. All rights reserved.
//

import Foundation
import SPManager
import SecuXPaymentKit

protocol AccountPaymentViewModelDelegate {
    func paymentDone(ret: Bool, errorMsg: String)
    func updatePaymentStatus(status: String)
    func noPaymentDevice()
}

class AccountPaymentViewModel: NSObject{
    
    let secXSvrReqHandler = SecuXServerRequestHandler()
    let paymentPeripheralManager = PaymentPeripheralManager.init()
  
    
    var delegate : AccountPaymentViewModelDelegate?
    
    /*
    func genEncryptCode(devID: String, ivKey: String) -> Data{
        
        let peripheralId = devID
        let terminalId = String(peripheralId.suffix(8))
        // amount must be 4 bytes. if it is less than 4 bytes, please put spaces before amount
        let amount = "100"
        
        //If amount is  not 4 digits, pad spaces as prefix
        let amountStr = String(String(amount.reversed()).padding(toLength: 8, withPad: " ", startingAt: 0).reversed())
        

        
        // transactionTime must be yyyyMMddHHmmss format
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        let transactionTime = formatter.string(from: date)
        formatter.dateFormat = "mmss"
        
        // transactionId is 16 bytes. it's testing data in sample code.
        let lastFourDigit = formatter.string(from: date)
        let transactionId = "P12345678912" + "\(lastFourDigit)"
        
        // concate transaction data
        let decryptedTransaction = "\(transactionTime),\(transactionId),\(terminalId),\(String(describing: amountStr)),TWD"
        
        // Simulate Server AES CBC encryption in App, please transfer these code to your server
        let encryptionKeyTF = "PA123456789012345678901234567890"
        
        let plaintext: NSData = decryptedTransaction.data(using: .utf8)! as NSData
        let encryptKey = encryptionKeyTF.data(using: .utf8)
        let iv = ivKey.data(using:.utf8)
        var encrypted = Data()
        let encryptor = Engine(operation: .encrypt, key: encryptKey!, iv: iv!)
        encrypted.append(encryptor.update(withData: plaintext as Data))
        encrypted.append(encryptor.finalData())
        print("decryptedTransaction:[\(decryptedTransaction)]")
        print("encryptKey: \(String(describing: encryptKey))")
        print("ivKey: \(String(describing: ivKey))")
        print("encrypted finalData:")
        
        return encrypted
    }
    
    
    func sendInfoToDevice(ivKey: String, devid: String, amount: String){
        
        /*
        //let decentRestAPIsHandler = DecentifunportalRestfulHandler()
        //decentRestAPIsHandler.payMoney(deviceID: devid, account: self.theAccount!, amount: 30, ivkey: ivKey)
        */
        
        let terminalId = String(devid.suffix(8))
        // amount must be 4 bytes. if it is less than 4 bytes, please put spaces before amount
        //let a = self.amountInputField.text! as String?
        //let amount = "\(String(describing: a!))"
        
        //If amount is  not 4 digits, pad spaces as prefix
        let amountStr = String(String(amount.reversed()).padding(toLength: 8, withPad: " ", startingAt: 0).reversed())
        

        
        // transactionTime must be yyyyMMddHHmmss format
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        let transactionTime = formatter.string(from: date)
        formatter.dateFormat = "mmss"
        
        // transactionId is 16 bytes. it's testing data in sample code.
        let lastFourDigit = formatter.string(from: date)
        let transactionId = "P12345678912" + "\(lastFourDigit)"
        
        
        // concate transaction data
        let decryptedTransaction = "\(transactionTime),\(transactionId),\(terminalId),\(String(describing: amountStr)),TWD"
        
        // Simulate Server AES CBC encryption in App, please transfer these code to your server
        let plaintext: NSData = decryptedTransaction.data(using: .utf8)! as NSData
        
        let encryptionKey = "PA123456789012345678901234567890"
        let encryptKey = encryptionKey.data(using: .utf8)
        let iv = ivKey.data(using:.utf8)
        var encrypted = Data()
        let encryptor = Engine(operation: .encrypt, key: encryptKey!, iv: iv!)
        encrypted.append(encryptor.update(withData: plaintext as Data))
        encrypted.append(encryptor.finalData())
        print("decryptedTransaction:[\(decryptedTransaction)]")
        print("encryptKey: \(String(describing: encryptKey))")
        print("ivKey: \(String(describing: ivKey))")
        print("encrypted finalData:")
        
        let machineControlParams = ["uart":"0","gpio1":"0","gpio2":"0","gpio31":"0","gpio32":"0","gpio4":"0","runStatus":"0","lockStatus":"0","gpio4c":"0","gpio4cInterval":"0","gpio4cCount":"0","gpio4dOn":"0","gpio4dOff":"0","gpio4dInterval":"0"]
        self.paymentPeripheralManager.doPaymentVerification(encrypted, machineControlParams: machineControlParams)
        { (result, error) in
            
            if (error == nil) {
                
                let amount = result?["amount"]
                let sequenceNo = result?["sequenceNo"]
                
            }
            else {
                var msgStr:String = "\(String(describing: error))"
                if let responseCode = result?["responseCode"] as? NSData {
                    msgStr += " ,responeCode:\(responseCode)"
                }
                
            }
        }
        
        
    }
    */
    
    func sendInfoToDevice(account: Account, coinType: CoinType, devID: String, storeName: String, ivKey: String, amount: String){
        
        logw("AccountPaymentViewModel sendInfoToDevice")
        
        
        var fromAcc = account.name
        if coinType == .LBR{
            fromAcc = account.theAddress
        }
        
        let param : [String:String] = ["coinType" : coinType.rawValue,
                                       "from" : fromAcc,
                                        "txId" : "P123456789123456",
                                        "to" : devID,
                                        "amount" : amount,
                                        "ivKey" : ivKey,
                                        "memo" : storeName,
                                        "currency" : coinType.rawValue]
        
        
        print(param)
        

        let (ret, data) = self.secXSvrReqHandler.doPayment(param: param)
        if ret, let payInfo = data {
            //var str = String(decoding: payInfo, as: UTF8.self)
            
            do{
                let json  = try JSONSerialization.jsonObject(with: payInfo, options: []) as! [String : Any]
                print("sendInfoToDevice recv \(json)  \n--------")
                
                //var payRet = true
                //var errorMsg = ""
                if let machineControlParams = json["machineControlParam"] as? [String : Any],
                    let encryptedStr = json["encryptedTransaction"] as? String {
                    
                    let encrypted = Data(base64Encoded: encryptedStr)
                    
                    /*
                    let machineControlParams2 : [String : String] = ["uart":"0","gpio1":"0","gpio2":"0","gpio31":"0","gpio32":"0","gpio4":"0","runStatus":"0","lockStatus":"0","gpio4c":"0","gpio4cInterval":"0","gpio4cCount":"0","gpio4dOn":"0","gpio4dOff":"0","gpio4dInterval":"0"]
                    let encrypted2 = self.genEncryptCode(devID: devID, ivKey: ivKey)
                    
                    */
                    logw("AccountPaymentViewModel doPaymentVerification")
                   
                    self.delegate?.updatePaymentStatus(status: "Device verifying ...")
                    
                    self.paymentPeripheralManager.doPaymentVerification(encrypted, machineControlParams: machineControlParams){ (result, error) in
                     
                        logw("AccountPaymentViewModel doPaymentVerification done")
                        if (error != nil) {
                         
                            var msgStr:String = "\(String(describing: error))"
                            if let responseCode = result?["responseCode"] as? NSData {
                                msgStr += " ,responeCode:\(responseCode)"
                            }
                            self.delegate?.paymentDone(ret: false, errorMsg: msgStr)
                            return

                        }else{
                            print("payment verification done!")
                            self.delegate?.paymentDone(ret: true, errorMsg: "")
                            return
                        }
                        
                    }

                    
                }else{
                    
                    logw("sendInfoToDevice failed \(param)")
                    
                    if let code = json["statusCode"] as? Int{
                        logw("sendInfoToDevice failed \(code)")
                    }
                    
                    if let error = json["statusDesc"] as? String{
                        logw("sendInfoToDevice failed \(error)")
                    }
                    
                    self.delegate?.paymentDone(ret: false, errorMsg: "Get payment data from server failed.")
                }
                
            
                
            }catch{
                print("doPayment error: " + error.localizedDescription)
                self.delegate?.paymentDone(ret: false, errorMsg: error.localizedDescription)
                return
            }
            
           
        }else{
            print("doPayment failed!!")
            self.delegate?.paymentDone(ret: false, errorMsg: "Send request to server failed.")
            
        }
        
        

    }
     
    func doPayment(account: Account, coinType: CoinType, devID: String, storeName: String, amount: String) {
        
        logw("AccountPaymentViewModel doPayment \(account.name) \(devID) \(amount)")
        
        let scanInterval = 3.0  //Put your scan interval value as you wish, here is  3.0 seconds.
        let rssiValueToCheck = -90 //Put your rssi value for range scan, here is -90 (far distanc
        
        self.delegate?.updatePaymentStatus(status: "Device connecting...")
        
        
        paymentPeripheralManager.discoverNearbyPeripherals(scanInterval,
            checkRSSI: Int32(rssiValueToCheck)) { result, error in
                     
            logw("result was \(String(describing: result)), and error was \(String(describing: error))")
                                                        
                     
            if let error = error{
                self.delegate?.paymentDone(ret: false, errorMsg: error.localizedDescription)

                
                return
            }
                
            if result?.count == 0{
                self.delegate?.noPaymentDevice()
                return
            }
        
            
            self.paymentPeripheralManager.doPeripheralAuthenticityVerification(3, connectDeviceId: devID, checkRSSI: (Int32(-80)), connectionTimeout: 5) { result, error in
        
                logw("AccountPaymentViewModel doPeripheralAuthenticityVerification done")
            
                if let error = error { // there is an error from SDK
                    print("error: \(String(describing: error))")
                    
                    let code = (error as NSError).code
                    if code == 25 || result?.count == 0{
                        self.delegate?.noPaymentDevice()
                        return
                    }
                    //self.showMessage(title: "Error", message: msg)
                   
                    self.delegate?.paymentDone(ret: false, errorMsg: error.localizedDescription)
                   
                }else {  // get ivKey for data encryption
                    self.paymentPeripheralManager.doGetIvKey { result, error in
                        
                       logw("AccountPaymentViewModel doGetIvKey done")
                       
                       
                        if ((error) != nil) {
                           logw("error: \(String(describing: error))")
                           self.delegate?.paymentDone(ret: false, errorMsg: String(describing: error))
                           
                        }else if let ivKey = result{
                            print("ivKey: \(String(describing: ivKey))")
                            
                           self.delegate?.updatePaymentStatus(status: "\(coinType.rawValue) transferring...")
                            
                           //DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                               
                            DispatchQueue.global(qos: .default).async{
                            
                                self.sendInfoToDevice(account: account, coinType: coinType, devID: devID, storeName: storeName, ivKey: ivKey, amount: amount)
                           
                           }
                           

                        }else{
                           self.delegate?.paymentDone(ret: false, errorMsg: "No ivkey")
                       }
                    }
                }
            }
                                                        
                                                        
        }
        
        
        
        
      
     }
    
    
    func getAccountInfo(coinType: String, devID: String) -> (Bool, String, String){
        
        logw("getAccountInfo \(coinType) \(devID)")
        
        /*
         {
            "coinType" : "IFC",
            "type" : "Device",
         "id":"4ab10000726b"
         }
         */
        
        let param = ["coinType": coinType, "id" : devID, "type" : "Device",]
        let (ret, data) = self.secXSvrReqHandler.getAccountInfo(param: param)
        if ret, let accInfo = data{
            
            do{
                
                let json  = try JSONSerialization.jsonObject(with: accInfo, options: []) as! [String : Any]
                //print(json)
                
                /*
                 {
                     "coinType": "IFC",
                     "type": "Device",
                     "id": "4ab10000726b",
                     "name": "Secux-Maochu",
                     "icon": ""
                 }
                 */
                
                if let name = json["name"] as? String, let img = json["icon"] as? String{
                    return (true, name, img)
                }else{
                    logw("getAccountInfo no name/img  \(json)")
                }
                
            }catch{
                logw("getAccountInfo error: " + error.localizedDescription)
            }
            
        }
        
        return (false, "", "")
    }
}
