//
//  AccountPayViewController.swift
//  SecuXWallet
//
//  Created by Maochun Sun on 2019/11/8.
//  Copyright © 2019 Maochun Sun. All rights reserved.
//

import UIKit
import swiftScan
import SPManager
import LocalAuthentication

import AVFoundation
import SecuXPaymentKit

class PaymentDetailsViewController: BaseViewController {
    
    var theAccount: Account?
    
    var showAccountSelection = false
    var storeName : String = "" {
        didSet{
            self.storeNameLabel.text = storeName
        }
    }
    
    var coinType : CoinType = CoinType.DCT {
        didSet{
            
            if let account = Wallet.shared.getAccount(type: self.coinType){
                self.theAccount = account
                
                Wallet.shared.getAccountBalanceAsync(account: account)
                
                
                if self.showAccountSelection{
                    self.accountInfoView.setupWithDropdownBtn(account: account)
                    
                }else{
                    self.accountInfoView.setup(account: account)
                }
                
                
                if let coinImg = account.getCoinImg(){
                    self.amountInputField.leftImage = coinImg
                }
                
                self.amountInputField.rightTxt = self.coinType.rawValue
            }
                
               
          
        }
    }
    
    var amount : String = "0"{
        didSet{
            if self.amount == "0"{
                self.amountInputField.editText = ""
            }else{
                self.amountInputField.editText = amount
            }
        }
    }
    
    var deviceID : String = ""

    var paymentMgr: SecuXPaymentManager?
    var paymentInfo: String = ""
    
    lazy var storeNameLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "N/A"
        
        label.font = UIFont(name: "Helvetica-Bold", size: 25)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = UIColor(red: 0x75/0xFF, green: 0x75/0xFF, blue: 0x75/0xFF, alpha: 1)
        label.textAlignment = NSTextAlignment.center
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        
        self.view.addSubview(label)
        
        
        NSLayoutConstraint.activate([
        
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
         
        
        ])
        
        
        return label
    }()
    
    lazy var storeImg: UIImageView = {

        let imageView = UIImageView()
        imageView.image = UIImage(named: "store_loading_icon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        
        if self.showAccountSelection{
            NSLayoutConstraint.activate([
               
                imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                imageView.topAnchor.constraint(equalTo: self.storeNameLabel.bottomAnchor, constant: 10),
                imageView.widthAnchor.constraint(equalToConstant: 100),
                imageView.heightAnchor.constraint(equalToConstant: 100)
               
            ])
        }else{
            NSLayoutConstraint.activate([
               
                imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                imageView.topAnchor.constraint(equalTo: self.storeNameLabel.bottomAnchor, constant: 10),
                imageView.widthAnchor.constraint(equalToConstant: 150),
                imageView.heightAnchor.constraint(equalToConstant: 150)
               
            ])
        }
        
        
        return imageView
    }()
    
    lazy var accountLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Payment Account"
        
        label.font = UIFont(name: UISetting.shared.boldFontName, size: 20)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = UIColor(red: 0x1F/0xFF, green: 0x20/0xFF, blue: 0x20/0xFF, alpha: 1)
        label.textAlignment = NSTextAlignment.left
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        
        self.view.addSubview(label)
        
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: self.storeImg.bottomAnchor, constant: 20),
            label.leftAnchor.constraint(equalTo: self.payButton.leftAnchor, constant: 0)
        
        ])
        
        
        return label
    }()
    
    
    lazy var accountInfoView : AccountInfoView = {
        let cell = AccountInfoView()
        cell.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        if let acc = Wallet.shared.getAccount(type: self.coinType){
            if self.showAccountSelection{
                cell.setupWithDropdownBtn(account: acc)
            }else{
                cell.setup(account: acc)
            }
        }
        
        
        self.view.addSubview(cell)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(accountTappedAction(_:)))

        cell.isUserInteractionEnabled = true
        cell.addGestureRecognizer(tap)
        
        NSLayoutConstraint.activate([
            
            
            cell.topAnchor.constraint(equalTo: self.accountLabel.bottomAnchor, constant: 8.67),
            
            cell.widthAnchor.constraint(equalToConstant: 350),
            cell.heightAnchor.constraint(equalToConstant: 70),
            cell.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            
        ])
       
        
        return cell
        
    }()
    
    lazy var amountLabel : UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Amount"
        
        label.font = UIFont(name:UISetting.shared.boldFontName, size: 20)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = UIColor(red: 0x1F/0xFF, green: 0x20/0xFF, blue: 0x20/0xFF, alpha: 1)
        label.textAlignment = NSTextAlignment.left
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        
        self.view.addSubview(label)
        
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: self.accountInfoView.bottomAnchor, constant: 20),
            label.leftAnchor.constraint(equalTo: self.payButton.leftAnchor, constant: 0)
        
        ])
        
        
        return label
    }()
    
    
    
    lazy var amountInputField: UnderlineIconTextField = {
        
        
        let input = UnderlineIconTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        //input.rightTxt = self.coinType.rawValue
        //input.theTextField.text = self.amount
        input.setup(hasLeftIcon: true, hasRightTxt: true)
        input.setTextFieldDelegate(delegate: self)
        input.keyboardType = .numberPad
        
        self.view.addSubview(input)
        
        
        NSLayoutConstraint.activate([
            
            
            input.topAnchor.constraint(equalTo: self.amountLabel.bottomAnchor, constant: 8.67),
            
            input.widthAnchor.constraint(equalToConstant: 300),
            input.heightAnchor.constraint(equalToConstant: 40),
            input.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            
        ])

        return input
    }()
    
    lazy var payButton:  UIRoundedButtonWithGradientAndShadow = {
        
        let btn = UIRoundedButtonWithGradientAndShadow(gradientColors: [UIColor(red: 0xEB/0xFF, green: 0xCB/0xFF, blue: 0x56/0xFF, alpha: 1), UIColor(red: 0xEB/0xFF, green: 0xCB/0xFF, blue: 0x56/0xFF, alpha: 1)])
        
    
    
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 22)
        btn.setTitleColor(UIColor(red: 0x1F/0xFF, green: 0x20/0xFF, blue: 0x20/0xFF, alpha: 1), for: .normal)
        btn.setTitleColor(UIColor.white, for: .disabled)
        btn.setTitle(NSLocalizedString("Pay", comment: ""), for: .normal)
        //btn.setBackgroundColor(UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), for:.disabled)
        btn.addTarget(self, action: #selector(payAction), for: .touchUpInside)
        
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowRadius = 2
        btn.layer.shadowOffset = CGSize(width: 2, height: 2)
        btn.layer.shadowOpacity = 0.3
        
        self.view.addSubview(btn)
        
        
        
        NSLayoutConstraint.activate([
            
            btn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -26),
            btn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            btn.widthAnchor.constraint(equalToConstant: 308),
            btn.heightAnchor.constraint(equalToConstant: 46)
            
        ])
       
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        var _ = self.storeNameLabel
        var _ = self.storeImg
        var _ = self.accountLabel
        
        var _ = self.amountLabel
        var _ = self.amountInputField
        var _ = self.payButton
        
        var _ = self.accountInfoView
        
        self.view.backgroundColor = .white
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        //User SecuXPaymentManager to get store info. and do payment
        self.paymentMgr = SecuXPaymentManager()
        
        //Must set the delegate of the SecuXPaymentManager
        self.paymentMgr!.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        logw("Payment details page")
        super.viewWillAppear(animated)
        
        
        self.payButton.isEnabled = false
        
        self.showProgress(info: "Loading...")
        self.paymentMgr!.getStoreInfo(paymentInfo: self.paymentInfo)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.accountInfoView.removeAccountBalanceObserver()
    }
    

    @objc func accountTappedAction(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        
        if !self.showAccountSelection{
            return
        }
        
        self.accountInfoView.dropdownToggle()
        
        let vc = PaymentAccountSelectionViewController()
        var vcHeight = 70 * Wallet.shared.getAccounts().count + 10
        if vcHeight > 220{
            vcHeight = 220
        }
        vc.preferredContentSize = CGSize(width: 340, height: vcHeight)
        vc.modalPresentationStyle = UIModalPresentationStyle.popover
        vc.selAccount = self.accountInfoView.theAccount

        let popoverPresentationController = vc.popoverPresentationController
        popoverPresentationController?.sourceView = self.accountInfoView
        popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        popoverPresentationController?.sourceRect = CGRect(x: self.accountInfoView.frame.size.width / 2 , y: self.accountInfoView.frame.size.height - 10, width: 0, height: 0)
        popoverPresentationController?.delegate = self
        popoverPresentationController?.backgroundColor = .white

        self.present(vc, animated: true, completion: nil)
        
    }
   

    @objc func payAction(){

        //let amount = self.amountInputField.text ?? ""
        
        //self.showMessageSync(title: "Payment successful!", message: "\(storeName)\n\(amount)")
        
        if self.coinType != .DCT, self.coinType != .IFC, self.coinType != .LBR{
            self.showMessage(title: "Unsupported coin!", message: "")
            return
        }
        
        if let amtTxt = self.amountInputField.text, amtTxt.count == 0{
            self.showMessage(title: "Invalid amount!", message: "Please input payment amount")
            return
        }
        
        self.amount = self.amountInputField.text ?? "0"
        
        
        if let dbamount = Double(self.amount), dbamount <= 0 {
            self.showMessage(title: "Invalid amount!", message: "Please input payment amount")
            return
        }
        
        if let acc = Wallet.shared.getAccount(type: self.coinType){
        
            if let dbamount = Double(self.amount),
                dbamount > acc.formatedBalance.value{
                self.showMessage(title: "You don't have enough money!", message: "Payment abort!")
                return
                
            }
            
            
            let localAuthContext = LAContext()
            
            if //localAuthContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
                localAuthContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil){
                
                let biometricType = localAuthContext.biometryType == LABiometryType.faceID ? "Face ID" : "Touch ID"
                logw("Supported Biometric type is: \( biometricType )")
                
                localAuthContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Pay \(self.amount) \(self.coinType) to \(self.storeName)") { success, evaluateError in
                    
                    
                    if success{
                        self.showProgress(info: "Processing...")
                        
                        
                        self.paymentMgr!.doPayment(account: Wallet.shared.getAccount(type: self.coinType)!, storeName: self.storeName, paymentInfo: self.paymentInfo)
                        
                    }else{
                        logw("Authentication failed!")
                    }
                                 
                }
            }

        }

    }
    
   
}


extension PaymentDetailsViewController: SecuXPaymentManagerDelegate{
    
    //Called when payment is completed. Returns payment result and error message.
    func paymentDone(ret: Bool, errorMsg: String) {
        
        self.hideProgress()
        
        DispatchQueue.main.async {
            
            
            let vc = PaymentResultViewController()
            
            let now:Date = Date()
            let dateFormat:DateFormatter = DateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString:String = dateFormat.string(from: now)
            
            if ret{

                var usdValue : Double = 0
                if let dbAmount = Double(self.amount),
                    let usdRate = Wallet.shared.getCoinToUSDRate(type: self.coinType){
                    usdValue = dbAmount * usdRate
                }
                
                let payInfo = PaymentHistoryInfo(storeName: self.storeName, accountName: self.theAccount!.name, coinType: self.coinType.rawValue, timestamp: dateString, amount: self.amount, amountUSD: "\(usdValue.roundToDecimal(2))")
                
                Wallet.shared.paymentHistory.insert(payInfo, at: 0)
                //Wallet.shared.savePaymentHistory()
                
                
                var soundID:SystemSoundID = 0
                let path = Bundle.main.path(forResource: "paysuccess", ofType: "wav")
                let baseURL = NSURL(fileURLWithPath: path!)
                AudioServicesCreateSystemSoundID(baseURL, &soundID)
                AudioServicesPlaySystemSound(soundID)
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))

                
                vc.amount = "\(self.amount) \(self.coinType.rawValue)"
                vc.result = true
                vc.timestamp = dateString
                vc.storeName = self.storeName
                
                //let customSoundId: SystemSoundID = 1005
                //AudioServicesPlaySystemSound(customSoundId)
                
                
                /*
                let alert = UIAlertController(title: "Payment successful!", message: "\(self.storeName)\n\(self.amount) \(self.coinType.rawValue)", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { alert -> Void in
                    
                    let now:Date = Date()
                    let dateFormat:DateFormatter = DateFormatter()
                    dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let dateString:String = dateFormat.string(from: now)
                    
                    var usdValue : Double = 0
                    if let dbAmount = Double(self.amount),
                        let usdRate = Coin.coinRate[self.coinType.rawValue]{
                        usdValue = dbAmount * usdRate
                    }
                    
                    let payInfo = PaymentHistoryInfo(storeName: self.storeName, accountName: self.theAccount!.name, coinType: self.coinType.rawValue, timestamp: dateString, amount: self.amount, amountUSD: "\(usdValue.roundToDecimal(2))")
                    
                    Wallet.shared.paymentHistory.insert(payInfo, at: 0)
                    Wallet.shared.savePaymentHistory()
                    
                    
                    let vc = PaymentHistoryViewController()
                    
                    self.navigationController?.pushViewController(vc, animated: false)
                    
                    
                })
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                */
                
            }else{
             
                //let customSoundId: SystemSoundID = 1052
                //let customSoundId: SystemSoundID = 1005
                //AudioServicesPlaySystemSound(customSoundId)
                
                /*
                var soundID:SystemSoundID = 0
                let path = Bundle.main.path(forResource: "payfailed", ofType: "wav")
                let baseURL = NSURL(fileURLWithPath: path!)
                AudioServicesCreateSystemSoundID(baseURL, &soundID)
                AudioServicesPlaySystemSound(soundID)
                */
                let soundID: SystemSoundID = 1053
                AudioServicesPlaySystemSound(soundID)
                usleep(500000)
                AudioServicesPlaySystemSound(soundID)
                
                vc.amount = "\(self.amount) \(self.coinType.rawValue)"
                vc.result = false
                vc.timestamp = dateString
                vc.storeName = self.storeName
                vc.failReason = errorMsg
                
                //self.showMessage(title: "Payment fail!", message: errorMsg)
            }
            
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    //Called when payment status is changed. Payment status are: "Device connecting...", "DCT transferring..." and "Device verifying..."
    func updatePaymentStatus(status: String) {
        print("=====Update payment status \(status)=====")
        self.updateProgress(info: status)
    }
    
    
    //Called when get store information is completed. Returns store name and store logo.
    func getStoreInfoDone(ret: Bool, storeName: String, storeLogo: UIImage) {
        print("getStoreInfoDone")
        
        self.hideProgress()
        if ret{

            self.storeName = storeName
            self.storeImg.image = storeLogo
   
            if self.amount != "0"{
                self.amountInputField.enableTextField = false
                self.payButton.isEnabled = true
            }else{
                self.payButton.isEnabled = false
            }

        }else{
            self.showMessage(title: "Invalid device ID!", message: "")
            self.payButton.isEnabled = false
            
        }
        
    }
    
    
   
}

extension PaymentDetailsViewController: UIPopoverPresentationControllerDelegate{
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController){
        
        print("popup menu dismissed")
        
        DispatchQueue.main.async {
            self.accountInfoView.dropdownToggle()
        }
        
        if let vc = popoverPresentationController.presentedViewController as? PaymentAccountSelectionViewController,
            let acc = vc.selAccount {
            
            DispatchQueue.main.async {
               
                self.coinType = vc.selAccType ?? acc.type
         
                
                
            }
            
            
            
            
        }
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
       return .none
    }
}


extension PaymentDetailsViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField){
        print("start editing")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        if textField == self.amountInputField.theTextField,
            let amtTxt = self.amountInputField.text, amtTxt.count > 0,
            let nAmt = Int(amtTxt), nAmt > 0{
            
            self.amount = String(nAmt)
        
            self.payButton.isEnabled = true
            
            
            
        }else{
            self.payButton.isEnabled = false
        }
    }
}
